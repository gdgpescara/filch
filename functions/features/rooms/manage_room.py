from firebase_functions.https_fn import on_request
from flask import jsonify, Request
from firestore_client import client
from features.rooms.types.room import Room
from features.rooms.types.delay import Delay
from features.sessions.types.session import Session
from shared.env import FIREBASE_REGION
from firebase_admin import firestore
from logger_config import logger

COLLECTION_ROOM_NAME = "rooms"
COLLECTION_DELAY_NAME = "room_delays"


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


@on_request(region=FIREBASE_REGION)
def add_delay(request: Request) -> bool:
    data = request.get_json(silent=True) or {}
    roomId = data.get("roomId", None)
    if roomId is not None: roomId = str(roomId)
    delay = int(data.get("delay", 0))
    if delay != 0:
        if roomId is None:
            ids = fetch_room_ids()
            if len(ids):
                batch = client.batch()
                for room_id in ids:
                    d = Delay(roomId=int(room_id), delay=delay)
                    ref = client.collection(COLLECTION_DELAY_NAME).document(room_id)
                    batch.set(ref, {"delay": firestore.Increment(d.delay), 'roomId': d.roomId}, merge=True)
                batch.commit()
                logger.info(f'Incrementato Ritardo di tutte le stanze di {delay} minuti')
        else:
            d = Delay(roomId=int(roomId), delay=delay)
            client.collection(COLLECTION_DELAY_NAME).document(roomId).set({"delay": firestore.Increment(d.delay), 'roomId': d.roomId}, merge=True)
    return jsonify(True)
