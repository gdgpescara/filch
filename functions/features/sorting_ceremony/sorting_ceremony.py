import random
from firebase_functions.https_fn import on_call, CallableRequest
from google.cloud.firestore import SERVER_TIMESTAMP
from firebase_admin import auth

from shared.get_signed_in_user import get_signed_in_user
from firestore_client import client as firestore_client
from logger_config import logger
from shared.env import FIREBASE_REGION


@on_call(region=FIREBASE_REGION)
def sorting_ceremony(request: CallableRequest) -> str:
    logged_user = get_signed_in_user(request)

    logged_user_claims = logged_user.custom_claims if logged_user.custom_claims else {}
    user_team = logged_user_claims.get("team", None)

    if user_team is not None:
        logger.info(f"User {logged_user.email} is already in a team: {user_team}")
        return "user_already_in_team"

    teams_data = firestore_client.collection("teams").where('assignable', '==', True).get()
    teams = {team.id: team.get("membersCount") for team in teams_data if team.exists}
    
    sizes =  [teams[team_id] for team_id in teams]
    min_size = min(sizes)
    candidates = [team_id for team_id, size in teams.items() if size == min_size]
    chosen_team = random.choice(candidates)
    
    logger.info(f"User {logged_user.email} assigned to team {chosen_team}")
    
    firestore_client \
        .collection("users") \
        .document(logged_user.uid) \
        .update({
            "team": chosen_team,
            "teamAssignedAt": SERVER_TIMESTAMP
        })

    auth.set_custom_user_claims(logged_user.uid, {**logged_user_claims, "team": chosen_team})

    return chosen_team