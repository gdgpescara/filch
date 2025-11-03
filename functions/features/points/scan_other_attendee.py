import json
from pydantic import BaseModel
from firebase_functions.https_fn import on_call, CallableRequest
from firebase_admin import auth
from firestore_client import client as firestore_client
from features.user.types.user import User
from features.points.types.points import Points
from features.points.types.points_type_enum import PointsTypeEnum
from logger_config import logger
from shared.get_signed_in_user import get_signed_in_user
from shared.env import FIREBASE_REGION, COLLECTION_USER, SUBCOLLECTION_POINT, ASSIGN_POINT_EVERY, ONLY_ONE_TIME, POINTS_AFTER_SCAN, GET_POINTS_FROM_DB
from google.cloud.firestore import SERVER_TIMESTAMP


class ScanOtherAttendeePayload(BaseModel):
    points: int
    scanned_value: str


# TODO Testare
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

# TODO Testare funzione, gestire in modo intelligente i valori di ritorno
@on_call(region=FIREBASE_REGION)
def scan_other_team_attendee(req: CallableRequest) -> dict:
    logged_user = get_signed_in_user(request=req)
    logged_user_team = logged_user.custom_claims['team']

    payload = req.data
    # TODO Qui non posso creare l'istanza di quest perche' richiede dei campi che non ho in ingresso
    quest = payload['quest']

    scanned_user = auth.get_user(uid=json.loads(payload['scanned_value'])["uid"])
    scanned_user_data = firestore_client.collection(COLLECTION_USER).document(scanned_user.uid).get().to_dict()
    scanned_user_team = scanned_user_data['team']

    if scanned_user_team != logged_user_team:

        quest_id = quest.id

        hist_points = firestore_client.collection(COLLECTION_USER).document(logged_user.uid).collection(SUBCOLLECTION_POINT).where("quest", "==", quest_id).get()

        if ONLY_ONE_TIME:
            if len(hist_points) > 0:
                logger.info(f'Points for Quest {quest_id} Already Assigned to User {logged_user.email}')
                return {
                    "en": "Nice try, space explorer! Points for this alliance were already granted in a previous encounter. The universe remembers your deeds — no double rewards in this galaxy!",
                    "it": "Bel tentativo, esploratore spaziale! I punti per questa alleanza ti sono già stati assegnati in un incontro precedente. L’universo ricorda le tue imprese — niente doppi premi in questa galassia!"
                }

        past_scan = len(hist_points) + 1

        if past_scan % ASSIGN_POINT_EVERY == 0:
            emails = [point.to_dict()['assignedBy'] for point in hist_points]
            if scanned_user.email in emails:
                logger.info(f'User {scanned_user.email} Already Scanned By {logged_user.email}')
                return {
                    "en": "Déjà vu, agent! You've already linked with this ally before. No extra points this time, but your connection grows stronger across the galaxies!",
                    "it": "Déjà vu, agente! Hai già stretto un legame con questo alleato in passato. Nessun punto extra stavolta, ma la vostra connessione risplende ancora più forte tra le galassie!"
                }
            else:

                if GET_POINTS_FROM_DB:
                    assigned_points = POINTS_AFTER_SCAN
                    logger.info(f'Taking Points From Config: {assigned_points}')
                else:
                    assigned_points = quest.points[0]
                    logger.info(f'Taking Points From Quest: {assigned_points}')

                points = Points(
                    type=PointsTypeEnum.quest,
                    points=assigned_points,
                    assignedAt=SERVER_TIMESTAMP,
                    quest=quest_id,
                    assignedBy=scanned_user.email
                )
        else:
            assigned_points = 0
            points = Points(
                type=PointsTypeEnum.quest,
                points=assigned_points,
                assignedAt=SERVER_TIMESTAMP,
                quest=quest_id,
                assignedBy=scanned_user.email
            )

        logger.info(f'Assigning {assigned_points} For Scan Number {past_scan}')

        firestore_client.collection(COLLECTION_USER).document(logged_user.uid).collection(SUBCOLLECTION_POINT).add(points.model_dump())
        return {
            "en": "Well done! You’ve made a new intergalactic contact.\nYour knowledge grows… and so does your score!",
            "it": "Ottimo lavoro! Hai stabilito un nuovo contatto intergalattico. La conoscenza si espande… e il tuo punteggio anche!"
        }

    else:
        return {
            "en": "Wow, takes one to know one!\nNo points for this match, but every bond makes your intergalactic network stronger. United, you’re a cosmic force!",
            "it": "Wow, un altro come te! Nessun punto per questa scoperta, ma ogni alleanza rafforza la tua rete intergalattica. Uniti, siete una forza cosmica!"
        }
