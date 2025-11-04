from logger_config import logger
from firebase_functions.https_fn import on_call, CallableRequest
from firebase_admin import auth
from features.points.types.points import Points
from shared.get_signed_in_user import get_signed_in_user
from features.points.types.points_type_enum import PointsTypeEnum
from firestore_client import client as firestore_client
from google.cloud.firestore import SERVER_TIMESTAMP
from shared.env import COLLECTION_USER, COLLECTION_QUEST, SUBCOLLECTION_QUEUE, SUBCOLLECTION_POINT, FIREBASE_REGION


@on_call(region=FIREBASE_REGION)
def assign_points(request: CallableRequest) -> str:
    logged_user = get_signed_in_user(request)

    assigned_points = int(request.data.get("points"))
    point_type = request.data.get("type")
    quest_id = request.data.get("quest", None)
    user_ids = request.data.get("users", [])
    users = [auth.get_user(uid) for uid in user_ids]
    filtered_users = []

    # If the point type is staff, community, or sponsor, ensure no duplicate assignments
    if point_type in (PointsTypeEnum.staff, PointsTypeEnum.community, PointsTypeEnum.sponsor):
        batch = firestore_client.batch()

        for user in users:
            user_points_snap = (
                firestore_client.collection(COLLECTION_USER)
                .document(user.uid)
                .collection(SUBCOLLECTION_POINT)
                .where("type", "==", point_type)
                .where("assignedBy", "==", logged_user.email)
                .get()
            )

            if user_points_snap:
                logger.info(f"User: {user.uid} already has points")
            else:
                filtered_users.append(user)

        batch.commit()
    else:
        filtered_users = users

    # If no users to assign points to, return early
    if not filtered_users:
        return "points_already_assigned"

    points = Points(
        type=point_type,
        points=assigned_points,
        assignedAt=SERVER_TIMESTAMP,
        quest=quest_id,
        assignedBy=logged_user.email
    )

    logger.info(f"Points: {points}")

    batch = firestore_client.batch()

    for user in filtered_users:
        user_points_ref = (
            firestore_client.collection(COLLECTION_USER)
            .document(user.uid)
            .collection(SUBCOLLECTION_POINT)
            .document()
        )
        batch.set(user_points_ref, points.model_dump(exclude_none=True))

        if point_type == PointsTypeEnum.quest and quest_id:
            logger.info("Is quest points removing active quest and queue")

            # Get the user document
            doc_ref = firestore_client.collection(COLLECTION_USER).document(user.uid)
            user_data = doc_ref.get().to_dict() or {}

            # Check if this is the user's active quest
            active_quest = user_data.get("activeQuest", None)
            if active_quest and active_quest.get("quest", {}).get("id") == quest_id:
                # Remove active quest
                batch.update(doc_ref, {"activeQuest": None})

            # Remove user from quest queue
            queue_ref = (
                firestore_client.collection(COLLECTION_QUEST)
                .document(quest_id)
                .collection(SUBCOLLECTION_QUEUE)
                .document(user.uid)
            )
            batch.delete(queue_ref)

    batch.commit()

    return "success"
