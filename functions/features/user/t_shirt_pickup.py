import logging
from firebase_functions import https_fn
from firebase_admin import firestore
from shared.get_signed_in_user import get_signed_in_user
from shared.env import FIREBASE_REGION, COLLECTION_USER


@https_fn.on_call(region=FIREBASE_REGION)
def t_shirt_pickup(request: https_fn.CallableRequest) -> bool:
    logged_user = get_signed_in_user(request)

    # Check if the user is a staff member
    user_ref = firestore.client().collection(COLLECTION_USER).document(logged_user.get("uid"))
    user_doc = user_ref.get()

    if not user_doc.exists or not user_doc.get("staff"):
        logging.error(f"User {logged_user.get('uid')} is not authorized")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.PERMISSION_DENIED,
            message="You are not authorized to access this resource"
        )

    # Get the user ID from the request data
    user_id = request.data.get("userId")

    if not user_id:
        logging.error("No user ID provided for t-shirt pickup")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="No user ID provided for t-shirt pickup"
        )

    # Update the user's t-shirt pickup status
    target_user_ref = firestore.client().collection(COLLECTION_USER).document(user_id)
    target_user_ref.update({
        "tShirtPickup": True,
        "tShirtPickupRequested": True
    })

    logging.info(f"User {user_id} got their t-shirt")
    return True
