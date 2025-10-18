from firebase_functions.https_fn import on_call, CallableRequest, HttpsError, FunctionsErrorCode
from firebase_admin import firestore
from features.sessions.types.favorite import FavoriteSession
from shared import get_signed_in_user
from shared.env import FIREBASE_REGION
from firestore_client import client as firestore_client

@on_call(region=FIREBASE_REGION)
def toggle_favorite_session(request: CallableRequest) -> bool:
    try:
        logged_user = get_signed_in_user(request)
        session_id = request.data.get("sessionId")

        if session_id is None:
            raise HttpsError(FunctionsErrorCode.ABORTED, "sessionId is required")

        favorite_ref = (firestore_client.collection("users")
            .document(logged_user.uid)
            .collection("favorite_sessions")
            .document(session_id))

        favorite_doc = favorite_ref.get()

        if favorite_doc.exists:
            favorite_ref.delete()
            return False 
        else:
            favorite_data = FavoriteSession(
                addedAt=firestore.SERVER_TIMESTAMP
            )
            favorite_ref.set(favorite_data.model_dump())
            return True

    except HttpsError:
        raise
    except Exception as e:
        raise HttpsError(FunctionsErrorCode.INTERNAL, f"An error occurred: {str(e)}")

    
