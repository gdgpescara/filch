from shared.get_signed_in_user import verify_firebase_auth
from firebase_functions.https_fn import on_request
from firestore_client import client as firestore_client
from logger_config import logger
import json, requests
from flask import jsonify, Request
from typing import List

from shared.env import FIREBASE_REGION, SESSIONIZE_EVENT_ID
from features.speakers.types.speaker import Speaker
from features.sessions.types.session import Session
from features.speakers.fetch_from_sessionize import fetch_speakers
from features.sessions.fetch_from_sessionize import fetch_sessions


def get_event_id(request: Request) -> str:
    try:
        payload = request.get_json(silent=True) or {}
    except Exception as e:
        logger.error(f"Errore parsing JSON: {e}")
        payload = {}
    event_id = payload.get("event_id", None)
    if event_id is None and SESSIONIZE_EVENT_ID is None:
        logger.error("You Have To Specify an 'event_id' in Your Payload Or You Have To Set 'SESSIONIZE_EVENT_ID' venv")
        raise Exception("Can't Find An Event ID")
    elif event_id is not None:
        logger.info("Getting Event ID from Request")
        return event_id
    else:
        logger.info("Getting Event ID from venv")
        return SESSIONIZE_EVENT_ID


def upload_to_sessionize(data: List[Session | Speaker], collection_name: str) -> None:
    try:
        batch = firestore_client.batch()
        for d in data:
            doc_ref = firestore_client.collection(collection_name).document(d.id)
            session_dict = d.model_dump()
            batch.set(doc_ref, session_dict)
        batch.commit()
        logger.info(f"Uploaded {len(data)} sessions to Firestore.")
    except Exception as e:
        raise e


@on_request(region=FIREBASE_REGION)
def fetch_from_sessionize(request: Request) -> bool:
    # user_info = verify_firebase_auth(request=request)
    # logger.info(f"Logged User Info: {user_info}")
    event_id = get_event_id(request)
    speakers = fetch_speakers(event_id=event_id)
    upload_to_sessionize(data=speakers, collection_name="speakers")
    sessions = fetch_sessions(event_id=event_id)
    for session in sessions:
        for session_speaker in session.speakers:
            for speaker in speakers:
                if session_speaker.id == speaker.id:
                    session_speaker.profilePicture = speaker.profilePicture
                    break
    upload_to_sessionize(data=sessions, collection_name="sessions")
    return jsonify(True)
