from firebase_functions.https_fn import on_call, CallableRequest
from flask import jsonify, Request
from firestore_client import client
from features.rooms.types.room import Room
from features.rooms.types.delay import Delay
from features.sessions.types.session import Session
from shared.env import FIREBASE_REGION, COLLECTION_ROOM_NAME, COLLECTION_DELAY_NAME
from firebase_admin import firestore
from logger_config import logger
from shared.get_signed_in_user import get_signed_in_user


def infer_rooms_from_sessions(sessions: list[Session]) -> list[Room]:
    rooms_by_id = {
        session.room.id: Room(id=session.room.id, name=session.room.name)
        for session in sessions
        if session.room is not None
    }
    return list(rooms_by_id.values())


def fetch_room_ids() -> list[str]:
    rooms = client.collection(COLLECTION_ROOM_NAME).stream()
    ids = []
    for doc in rooms:
        ids.append(doc.id)
    return ids


@on_call(region=FIREBASE_REGION)
def add_room_delay(request: CallableRequest) -> bool:
    logger.info(f'Request data: {request.data}')
    delay = int(request.data.get("delay", 0))
    if delay == 0:
        return True

    signed_user = get_signed_in_user(request)

    roomId = request.data.get("roomId", None)
    if roomId is not None: roomId = str(roomId)

    delay_data = Delay(
        delay=firestore.Increment(delay),
        updatedAt=firestore.SERVER_TIMESTAMP,
        updatedBy=signed_user.email
    )
    
    if roomId is None:
        ids = fetch_room_ids()
        if len(ids):
            batch = client.batch()
            for room_id in ids:
                ref = client.collection(COLLECTION_DELAY_NAME).document(room_id)
                batch.set(ref, delay_data.model_dump(), merge=True)
            batch.commit()
            logger.info(f'Incrementato Ritardo di tutte le stanze di {delay} minuti')
    else:
        client.collection(COLLECTION_DELAY_NAME).document(roomId).set(delay_data.model_dump(), merge=True)
        logger.info(f'Incrementato Ritardo della stanza {roomId} di {delay} minuti')
    return True
