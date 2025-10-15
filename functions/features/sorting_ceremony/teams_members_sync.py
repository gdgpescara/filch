from firebase_functions.firestore_fn import on_document_created, on_document_deleted, Event, DocumentSnapshot
from firestore_client import client as firestore_client
from google.cloud.firestore import Increment

from logger_config import logger
from shared.env import FIREBASE_REGION


@on_document_created(
    document="teams/{id}/members/{uid}",
    region=FIREBASE_REGION
)
def on_team_member_created(event: Event[DocumentSnapshot]) -> None:
    
    logger.info(f"teams_members_sync triggered for document: {event}")

    firestore_client \
        .collection("teams") \
        .document(event.params["id"]) \
        .update({
            "membersCount": Increment(1)
        })


@on_document_deleted(
    document="teams/{id}/members/{uid}",
    region=FIREBASE_REGION
)
def on_team_member_deleted(event: Event[DocumentSnapshot]) -> None:

    logger.info(f"teams_members_sync triggered for document: {event}")

    firestore_client \
        .collection("teams") \
        .document(event.params["id"]) \
        .update({
            "membersCount": Increment(-1)
        })