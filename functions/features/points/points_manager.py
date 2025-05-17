import logging
from firebase_functions import firestore_fn
from firebase_admin import firestore


@firestore_fn.on_document_written(
    document="users/{uid}/points/{archivedPointsId}",
    region="europe-west3"
)
def user_points_sentinel(event: firestore_fn.Event[firestore_fn.DocumentSnapshot]) -> None:
    """
    Function triggered when a points document is written in a user's points subcollection.
    Updates the user's total points.
    """
    # Get the previous and current points values
    previous_points = 0
    if event.data.before and event.data.before.exists:
        previous_points = event.data.before.get("points") or 0
    
    current_points = 0
    if event.data.after and event.data.after.exists:
        current_points = event.data.after.get("points") or 0
    
    # If points have changed, update the user's total
    if previous_points != current_points:
        # Get a reference to the parent user document
        user_ref = event.data.after.reference.parent.parent
        
        if user_ref:
            # Get the current user data
            user_snap = user_ref.get()
            user_data = user_snap.to_dict()
            
            # Calculate the new total points
            current_total = user_data.get("points", 0) if user_data else 0
            new_total = current_total - previous_points + current_points
            
            # Update the user's points
            user_ref.update({"points": new_total})
            
            logging.info(f"Updated points for user {user_ref.id}: {current_total} -> {new_total}")
