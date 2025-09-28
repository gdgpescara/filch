from firebase_functions.https_fn import CallableRequest, HttpsError, FunctionsErrorCode
from firebase_admin import auth
from firebase_admin._user_mgt import UserRecord

from logger_config import logger


def get_signed_in_user(request: CallableRequest) -> UserRecord:
    uid = getattr(request.auth, "uid", None)

    if not uid:
        logger.error("User is not logged in")
        raise HttpsError(code=FunctionsErrorCode.UNAUTHENTICATED, message="User is not logged in")

    return auth.get_user(uid)


def verify_firebase_auth(request):
    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        logger.error("Missing Authorization header.")
        raise HttpsError(code=FunctionsErrorCode.UNAUTHENTICATED, message="Missing Authorization header.")

    id_token = auth_header.split("Bearer ")[1]
    try:
        decoded = auth.verify_id_token(id_token)
        return decoded
    except Exception:
        logger.error("Invalid token.")
        raise HttpsError(code=FunctionsErrorCode.UNAUTHENTICATED, message="Invalid token.")