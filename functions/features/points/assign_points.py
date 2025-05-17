import logging
from typing import List, Dict, Any, Optional
from firebase_functions import https_fn
from firebase_admin import firestore, auth
from shared.get_signed_in_user import get_signed_in_user
from features.points.types.points_type_enum import PointsTypeEnum
import datetime
from shared.env import FIREBASE_REGION


@https_fn.on_call(region=FIREBASE_REGION)
def assign_points(request: https_fn.CallableRequest) -> bool:
    """
    Cloud function to assign points to users.
    
    Args:
        request: Contains the auth context and the data for assigning points
        
    Returns:
        True if the operation was successful
    """
    # Get the logged in user
    logged_user = get_signed_in_user(request)
    
    logging.info(f"Assigning points: {request.data}")
    
    # Extract data from the request
    assigned_points = request.data.get("points")
    point_type = request.data.get("type")
    quest_id = request.data.get("quest")
    user_ids = request.data.get("users", [])
    
    # Get user objects for all user IDs
    users = [auth.get_user(uid) for uid in user_ids]
    
    # Filter users based on point type
    filtered_users = []
    
    if point_type == PointsTypeEnum.STAFF or point_type == PointsTypeEnum.COMMUNITY:
        # For staff or community points, check if users already have points of this type
        db = firestore.client()
        batch = db.batch()
        
        for user in users:
            # Check if user already has points of this type
            user_points_snap = (
                db.collection("users")
                .document(user.uid)
                .collection("points")
                .where("type", "==", point_type)
                .get()
            )
            
            if user_points_snap:
                logging.info(f"User: {user.uid} already has points")
            else:
                filtered_users.append(user)
                
        await batch.commit()
    else:
        # For other point types, include all users
        filtered_users = users
    
    # Create points data
    points_data = {
        "type": point_type,
        "points": assigned_points,
        "assignedBy": logged_user.get("uid"),
        "assignedAt": datetime.datetime.now(),
        "quest": quest_id
    }
    
    logging.info(f"Points: {points_data}")
    
    # Create a batch for Firestore operations
    db = firestore.client()
    batch = db.batch()
    
    # Process each user
    for user in filtered_users:
        # Add points to the user
        user_points_ref = (
            db.collection("users")
            .document(user.uid)
            .collection("points")
            .document()
        )
        batch.set(user_points_ref, points_data)
        
        # If quest points, handle active quest and queue
        if point_type == PointsTypeEnum.QUEST and quest_id:
            logging.info("Is quest points removing active quest and queue")
            
            # Get the user document
            user_doc_ref = db.collection("users").document(user.uid)
            user_doc = user_doc_ref.get()
            user_data = user_doc.to_dict()
            
            # Check if this is the user's active quest
            active_quest = user_data.get("activeQuest")
            if active_quest and active_quest.get("quest", {}).get("id") == quest_id:
                # Remove active quest
                batch.update(user_doc_ref, {"activeQuest": None})
            
            # Remove user from quest queue
            queue_ref = (
                db.collection("quests")
                .document(quest_id)
                .collection("queue")
                .document(user.uid)
            )
            batch.delete(queue_ref)
    
    # Handle actor quest timeline update
    if point_type == PointsTypeEnum.QUEST and quest_id:
        decoded_id = quest_id.split("-")
        if len(decoded_id) == 3 and decoded_id[0] == "actor":
            # Update timeline count
            timeline_ref = db.collection("timelines").document(decoded_id[1])
            timeline_doc = timeline_ref.get()
            
            if timeline_doc.exists:
                timeline_data = timeline_doc.to_dict()
                current_count = timeline_data.get("count", 0) if timeline_data else 0
                batch.set(timeline_ref, {"count": current_count + 1})
    
    # Commit all the changes
    batch.commit()
    
    return True
