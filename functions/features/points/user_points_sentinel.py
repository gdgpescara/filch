from firebase_functions.firestore_fn import on_document_written, Event, DocumentSnapshot
from google.cloud.firestore import Increment

from logger_config import logger
from shared.env import FIREBASE_REGION


@on_document_written(
    document="users/{uid}/points/{archivedPointsId}",
    region=FIREBASE_REGION
)
def user_points_sentinel(event: Event[DocumentSnapshot]) -> None:
    current_value = event.data.after
    prev_value = event.data.before

    current_points, prev_points = 0, 0
    if current_value and current_value.exists:
        current_points = current_value.to_dict().get("points", 0)
    if prev_value and prev_value.exists:
        prev_points = prev_value.to_dict().get("points", 0)


    # If points have changed, update the user's total
    if prev_points != current_points:
        # Get a reference to the parent user document
        user_ref = current_value.reference.parent.parent
        
        if user_ref:
            # TODO Chiedere se vale la pena fare accessi per solo debug
            # Get the current user data
            user_snap = user_ref.get()
            user_data = user_snap.to_dict()

            delta = current_points - prev_points
            current_total = user_data.get("points", 0) if user_data else 0
            new_total = current_total + delta

            user_ref.update({"points": Increment(delta)})
            
            logger.info(f"Updated points for user {user_ref.id}: {current_total} -> {new_total}")
