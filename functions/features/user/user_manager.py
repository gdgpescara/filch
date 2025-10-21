import logging
from firebase_functions import auth_fn
from firebase_admin import firestore
from features.user.types.user import User
from shared.env import COLLECTION_USER, FIREBASE_REGION


@auth_fn.on_user_deleted(region=FIREBASE_REGION)
def on_user_delete(event: auth_fn.AuthBlockingEvent) -> None:
    """
    Function triggered when a user is deleted from Firebase Auth.
    Deletes the user document from the Firestore database.
    """
    user = event.data

    batch = firestore.client().batch()

    user_ref = firestore.client().collection(COLLECTION_USER).document(user.uid)

    # Add here the documents were the user is referenced and delete them

    batch.delete(user_ref)
    
    batch.commit()

    logging.info(f"Deleted user {user.uid} from Firestore")


@auth_fn.on_user_created(region=FIREBASE_REGION)
def on_user_create(event: auth_fn.AuthBlockingEvent) -> None:
    """
    Function triggered when a new user is created in Firebase Auth.
    Creates a user document in the Firestore database.
    """
    auth_user = event.data
    
    user = User.from_auth_user(auth_user)
    
    firestore.client().collection(COLLECTION_USER).document(user.uid).set(user.to_dict())

    logging.info(f"Created user {user.uid} in Firestore")