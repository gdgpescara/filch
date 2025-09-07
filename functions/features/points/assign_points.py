from logger_config import logger
from firebase_functions.https_fn import on_call, CallableRequest, on_request, Request
from firebase_admin import auth
from google.cloud.firestore import SERVER_TIMESTAMP, Increment
from flask import jsonify

from shared.env import FIREBASE_REGION
from features.points.types.points import Points
from shared.get_signed_in_user import get_signed_in_user
from features.points.types.points_type_enum import PointsTypeEnum
from firestore_client import client as firestore_client


#TODO Testare questa funzione
@on_call(region=FIREBASE_REGION)
def assign_points(request: CallableRequest) -> bool:
    logged_user = get_signed_in_user(request)
    logger.info(f"Assigning points: {request.data}")
    assigned_points = request.data.get("points")
    point_type = request.data.get("type")
    quest_id = request.data.get("quest", None)
    user_ids = request.data.get("users", [])
    users = [auth.get_user(uid) for uid in user_ids]
    filtered_users = []

    if point_type == PointsTypeEnum.staff or point_type == PointsTypeEnum.community:
        batch = firestore_client.batch()

        for user in users:
            user_points_snap = (
                firestore_client.collection("users")
                .document(user.uid)
                .collection("points")
                .where("type", "==", point_type)
                .get()
            )

            if user_points_snap:
                logger.info(f"User: {user.uid} already has points")
            else:
                filtered_users.append(user)

        batch.commit()
    else:
        filtered_users = users

    points = Points(type=point_type, points=assigned_points,
                    assigned_at=SERVER_TIMESTAMP, quest=quest_id,
                    assigned_by=logged_user.uid)

    logger.info(f"Points: {points}")

    batch = firestore_client.batch()

    for user in filtered_users:
        user_points_ref = (
            firestore_client.collection("users")
            .document(user.uid)
            .collection("points")
            .document()
        )
        batch.set(user_points_ref, points.model_dump())

        if point_type == PointsTypeEnum.quest and quest_id:
            logger.info("Is quest points removing active quest and queue")

            # Get the user document
            doc_ref = firestore_client.collection("users").document(user.uid)
            user_data = doc_ref.get().to_dict() or {}

            # Check if this is the user's active quest
            active_quest = user_data.get("activeQuest", None)
            if active_quest and active_quest.get("quest", {}).get("id") == quest_id:
                # Remove active quest
                batch.update(doc_ref, {"activeQuest": None})

            # Remove user from quest queue
            queue_ref = (
                firestore_client.collection("quests")
                .document(quest_id)
                .collection("queue")
                .document(user.uid)
            )
            batch.delete(queue_ref)

    # Handle actor quest timeline update
    if point_type == PointsTypeEnum.quest and quest_id:
        decoded_id = quest_id.split("-")
        if len(decoded_id) == 3 and decoded_id[0] == "actor":
            timeline_ref = firestore_client.collection("timelines").document(decoded_id[1])
            if timeline_ref.get().exists:
                batch.update(timeline_ref, {"count": Increment(1)})

    batch.commit()

    return jsonify(True)
