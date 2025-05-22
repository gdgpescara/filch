import json
from pydantic import BaseModel
from firebase_functions.https_fn import on_call, CallableRequest
from google.cloud.firestore import SERVER_TIMESTAMP
from firebase_admin import auth

from features.points.types.points import Points
from features.points.types.points_type_enum import PointsTypeEnum
from logger_config import logger
from firestore_client import client as firestore_client
from shared.get_signed_in_user import get_signed_in_user


class ScanOtherAttendeePayload(BaseModel):
    points: int
    scanned_value: str


@on_call(region="europe-west3")
def scan_other_attendee(req: CallableRequest) -> bool:
    payload = req.data
    logger.debug(f"Input Payload: {payload}")

    payload = ScanOtherAttendeePayload(**payload)
    logged_user = get_signed_in_user(request=req)

    scanned_user = auth.get_user(uid=json.loads(payload.scanned_value)["uid"])
    if scanned_user:
        user_uid = scanned_user.uid
        logged_uid = logged_user.uid
        user_point_snap = (firestore_client.collection("users")
                           .document(logged_uid)
                           .collection("points")
                           .where("type", "==", PointsTypeEnum.QUEST)
                           .where("assignedFrom", "==", user_uid)
                           .get())
        logger.debug(f"Snapshot For User {user_uid}: {[doc.to_dict() for doc in user_point_snap]}")

        if user_point_snap:
            raise Exception("You have already scanned this user")

        points = Points(type=PointsTypeEnum.QUEST, points=payload.points,
                        assigned_at=SERVER_TIMESTAMP, assigned_from=user_uid)
        batch = firestore_client.batch()
        doc = (firestore_client
               .collection("users")
               .document(logged_uid)
               .collection("points")
               .document())
        batch.set(doc, points.model_dump())
        batch.commit()
        logger.info("Points added")
        return True
    else:
        logger.info("Scanned user not found")
        return False
