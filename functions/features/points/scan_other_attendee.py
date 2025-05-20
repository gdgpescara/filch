import json
from flask import jsonify
from pydantic import BaseModel
from firebase_functions.https_fn import on_call, on_request, Response, Request
from google.cloud.firestore import SERVER_TIMESTAMP
from firebase_admin import auth
from features.points.types.points import Points
from features.points.types.points_type_enum import PointsTypeEnum
from logger_config import logger
from firestore_client import client as firestore_client


# TODO Definire questo
# import {getSignedInUser} from "../../shared/get_signed_in_user";

class ScanOtherAttendeePayload(BaseModel):
    points: int
    scanned_value: str


# TODO Sostituire decorator e parametro dopo aver eseguito i test locali
# @on_call(region="europe-west3")
# req: https_fn.CallableRequest -> bool
@on_request(region="europe-west3")
def scan_other_attendee(req: Request) -> Response:
    payload = req.get_json()
    logger.debug(f"Input Payload: {payload}")

    payload = ScanOtherAttendeePayload(**payload)

    # TODO DA Definire
    logged_user = {}
    # logged_user = get_signed_in_user(req)

    scanned_user = auth.get_user(uid=json.loads(payload.scanned_value)["uid"])
    if scanned_user:
        user_uid = scanned_user.uid
        # TODO Fare check se è dizionario o oggetto
        logged_uid = logged_user["uid"]
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
        # TODO Modificare solo con True quando si passa a on_call
        return jsonify(True)
    else:
        logger.info("Scanned user not found")
        return jsonify(False)
