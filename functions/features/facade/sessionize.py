from firebase_functions.https_fn import on_call, CallableRequest, HttpsError, FunctionsErrorCode
from firestore_client import client as firestore_client
from logger_config import logger
from typing import Sequence, Union

from shared.env import FIREBASE_REGION, COLLECTION_SPEAKER_NAME, COLLECTION_ROOM_NAME, COLLECTION_SESSION_NAME
from features.speakers.types.speaker import Speaker
from features.sessions.types.session import Session
from features.rooms.types.room import Room
from features.speakers.fetch_from_sessionize import fetch_speakers
from features.sessions.fetch_from_sessionize import fetch_sessions
from features.rooms.manage_room import infer_rooms_from_sessions

EntityType = Union[Session, Speaker, Room]


def upload_to_firestore(data: Sequence[EntityType], collection_name: str) -> None:
    """
    Uploads a sequence of Session, Speaker, or Room objects to a specified Firestore collection.

    Args:
        data (Sequence[Session | Speaker | Room]): The list of objects to upload.
        collection_name (str): The name of the Firestore collection to upload the data to.

    Raises:
        Exception: If an error occurs during the upload process.
    """
    try:
        # Delete all documents in the collection if it exists
        collection_ref = firestore_client.collection(collection_name)
        docs = collection_ref.get()
        if docs:
            delete_batch = firestore_client.batch()
            for doc in docs:
                delete_batch.delete(doc.reference)
            delete_batch.commit()
            logger.info(f"Deleted existing documents in collection '{collection_name}'.")
        batch = firestore_client.batch()
        for d in data:
            doc_ref = collection_ref.document(str(d.id))
            session_dict = d.model_dump()
            batch.set(doc_ref, session_dict)
        batch.commit()
        logger.info(f"Uploaded {len(data)} items to Firestore collection '{collection_name}'.")
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
