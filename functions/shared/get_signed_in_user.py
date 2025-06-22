from firebase_functions.https_fn import CallableRequest, HttpsError, FunctionsErrorCode
from firebase_admin import auth
from firebase_admin._user_mgt import UserRecord

from logger_config import logger


def get_signed_in_user(request: CallableRequest) -> UserRecord:
    """
    Function to get the signed-in user from the request.
    
    Args:
        request: The request object containing the auth context.
    
    Returns:
        The signed-in user data or an error message.
    """
    uid = getattr(request.auth, "uid", None)

    if not uid:
        logger.error("User is not logged in")
        raise HttpsError(code=FunctionsErrorCode.UNAUTHENTICATED, message="User is not logged in")

    return auth.get_user(uid)
