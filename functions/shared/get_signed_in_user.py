import logging
from firebase_functions import https_fn
from firebase_admin import auth


def get_signed_in_user(request: https_fn.CallableRequest):
    """
    Function to get the signed-in user from the request.
    
    Args:
        request: The request object containing the auth context.
    
    Returns:
        The signed-in user data or an error message.
    """
    uid = request.auth.uid if request.auth else None

    if not uid:
        logging.error("User is not logged in")
        raise https_fn.HttpsError(code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
                                  message="User is not logged in")

    return auth.get_user(uid)._data
