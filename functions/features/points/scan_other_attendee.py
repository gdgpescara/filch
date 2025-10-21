import json
from pydantic import BaseModel
from firebase_functions.https_fn import on_call, CallableRequest
from firebase_admin import auth
from firestore_client import client as firestore_client
from features.points.types.points import Points
from features.points.types.points_type_enum import PointsTypeEnum
from logger_config import logger
from shared.get_signed_in_user import get_signed_in_user
from shared.env import FIREBASE_REGION, COLLECTION_USER, SUBCOLLECTION_POINT
from google.cloud.firestore import SERVER_TIMESTAMP


class ScanOtherAttendeePayload(BaseModel):
    points: int
    scanned_value: str


@on_call(region=FIREBASE_REGION)
def scan_other_attendee(req: CallableRequest) -> bool:
    payload = req.data

    payload = ScanOtherAttendeePayload(**payload)
    logged_user = get_signed_in_user(request=req)

    scanned_user = auth.get_user(uid=json.loads(payload.scanned_value)["uid"])
    if scanned_user:
        user_uid = scanned_user.uid
        logged_uid = logged_user.uid
        user_point_snap = (firestore_client.collection(COLLECTION_USER)
                           .document(logged_uid)
                           .collection(SUBCOLLECTION_POINT)
                           .where("type", "==", PointsTypeEnum.quest)
                           .where("assignedBy", "==", user_uid)
                           .get())

        if user_point_snap:
            raise Exception("You have already scanned this user")

        points = Points(
            type=PointsTypeEnum.quest, 
            points=payload.points,
            assignedAt=SERVER_TIMESTAMP, 
            assignedBy=user_uid
        )
        
        batch = firestore_client.batch()
        doc = (firestore_client
               .collection(COLLECTION_USER)
               .document(logged_uid)
               .collection(SUBCOLLECTION_POINT)
               .document())
        batch.set(doc, points.model_dump())
        batch.commit()
        
        logger.info("Points added")
        return True
    else:
        logger.info("Scanned user not found")
        return False
