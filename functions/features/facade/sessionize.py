from firebase_functions.https_fn import on_call, CallableRequest, HttpsError, FunctionsErrorCode
from firestore_client import client as firestore_client
from logger_config import logger
from typing import List

from shared.env import FIREBASE_REGION, SESSIONIZE_EVENT_ID
from features.speakers.types.speaker import Speaker
from features.sessions.types.session import Session
from features.rooms.types.room import Room
from features.speakers.fetch_from_sessionize import fetch_speakers, COLLECTION_SPEAKER_NAME
from features.sessions.fetch_from_sessionize import fetch_sessions, COLLECTION_SESSION_NAME
from features.rooms.manage_room import infer_rooms_from_sessions, COLLECTION_ROOM_NAME


def upload_to_firestore(data: List[Session | Speaker | Room], collection_name: str) -> None:
    try:
        batch = firestore_client.batch()
        for d in data:
            doc_ref = firestore_client.collection(collection_name).document(str(d.id))
            session_dict = d.model_dump()
            batch.set(doc_ref, session_dict)
        batch.commit()
        logger.info(f"Uploaded {len(data)} sessions to Firestore.")
    except Exception as e:
        raise e


@on_call(region=FIREBASE_REGION)
def fetch_from_sessionize(request: CallableRequest) -> bool:
    event_id = request.data.get("event_id", None)

    if event_id is None:
        raise HttpsError(FunctionsErrorCode.ABORTED, "event_id is required")

    try:
        speakers = fetch_speakers(event_id=event_id)
        upload_to_firestore(data=speakers, collection_name=COLLECTION_SPEAKER_NAME)
        sessions = fetch_sessions(event_id=event_id)
        for session in sessions:
            for session_speaker in session.speakers:
                for speaker in speakers:
                    if session_speaker.id == speaker.id:
                        session_speaker.profilePicture = speaker.profilePicture
                        session_speaker.bio = speaker.bio
                        session_speaker.links = speaker.links
                        session_speaker.tagLine = speaker.tagLine
                        break

        upload_to_firestore(data=sessions, collection_name=COLLECTION_SESSION_NAME)
        rooms = infer_rooms_from_sessions(sessions=sessions)
        upload_to_firestore(data=rooms, collection_name=COLLECTION_ROOM_NAME)
    except Exception as e:
        logger.error(f"Error fetching data from Sessionize: {str(e)}")
        raise HttpsError(FunctionsErrorCode.INTERNAL, f"Error fetching data from Sessionize: {str(e)}")
    
    return True
