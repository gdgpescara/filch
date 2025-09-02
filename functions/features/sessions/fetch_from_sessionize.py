from firestore_client import client as firestore_client
from firebase_functions.https_fn import on_request, HttpsError, FunctionsErrorCode
from typing import List
from features.sessions.types.session import Session, NamedEntity, SessionSpeaker
from shared.get_signed_in_user import verify_firebase_auth
from shared.env import FIREBASE_REGION
from shared.event_id import get_event_id
from logger_config import logger
import json, requests
from flask import jsonify, Request


def transform_sessions(raw_data: list) -> List[Session]:
    category_handlers = {
        "Session format": lambda items: ("sessionFormat", NamedEntity(id=items[0]["id"], name=items[0]["name"])),
        "Track": lambda items: ("tracks", [NamedEntity(id=item["id"], name=item["name"]) for item in items]),
        "Level": lambda items: ("level", NamedEntity(id=items[0]["id"], name=items[0]["name"])),
        "Language": lambda items: ("language", NamedEntity(id=items[0]["id"], name=items[0]["name"]))
    }

    result = []
    for group in raw_data:
        for session in group.get("sessions", []):
            pp_session = {
                "id": session.get("id"),
                "title": session.get("title"),
                "description": session.get("description"),
                "startsAt": session.get("startsAt"),
                "endsAt": session.get("endsAt"),
                "speakers": [SessionSpeaker(id=s.get("id"), name=s.get("name")) for s in session.get("speakers", [])],
                "roomId": session.get("roomId"),
                "room": session.get("room"),
                "sessionFormat": None,
                "tracks": None,
                "level": None,
                "language": None
            }

            for category in session.get("categories", []):
                name = category.get("name", None)
                items = category.get("categoryItems", [])
                if len(items) == 0 or name is None:
                    continue

                if name not in category_handlers:
                    logger.warning(f"Unknown Category '{name}' found in session '{session.get('id')}'. Skipping.")
                    continue

                key, value = category_handlers[name](items)
                pp_session[key] = value
            try:
                result.append(Session(**pp_session))
            except Exception as e:
                logger.exception(f"Error During Session Managing: {e}.")
                logger.info(f"Related Info Are {json.dumps(session, indent=2, ensure_ascii=False, default=str)}")
    return result


def upload_sessions_to_firestore(sessions: List[Session], collection_name: str = "session") -> None:
    try:
        batch = firestore_client.batch()
        for session in sessions:
            doc_ref = firestore_client.collection(collection_name).document(session.id)
            session_dict = session.model_dump()
            batch.set(doc_ref, session_dict)

        batch.commit()
        logger.info(f"Uploaded {len(sessions)} sessions to Firestore.")
    except Exception as e:
        raise e


@on_request(region=FIREBASE_REGION)
def fetch_sessions(request: Request) -> bool:
    # user_info = verify_firebase_auth(request=request)
    # logger.info(f"Logged User Info: {user_info}")
    url = f"https://sessionize.com/api/v2/{get_event_id(request)}/view/" + "Sessions"
    logger.info(f"Downloading Sessions From: {url}")
    try:
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            logger.info("Speakers JSON Fetched")
            try:
                raw_data = response.json()
                upload_sessions_to_firestore(sessions=transform_sessions(raw_data=raw_data))
            except json.JSONDecodeError:
                logger.exception("Error During Decoding Response")
                logger.info(f"Given Data Are: {raw_data}")
                raise HttpsError(
                    code=FunctionsErrorCode.INTERNAL,
                    message="Invalid JSON response from Sessionize"
                )
            except Exception as e:
                logger.exception(f"Generic Error: {e}")
                raise HttpsError(
                    code=FunctionsErrorCode.INTERNAL,
                    message="Unexpected error during session processing"
                )
        elif response.status_code == 404:
            logger.exception("Error 404. Can't Find Event or Event Not Public")
            raise HttpsError(
                code=FunctionsErrorCode.NOT_FOUND,
                message="Sessionize event not found or not public"
            )
        else:
            logger.exception(f"Error HTTP {response.status_code}: {response.reason}")
            raise HttpsError(
                code=FunctionsErrorCode.INTERNAL,
                message=f"Unexpected HTTP error from Sessionize: {response.status_code} - {response.reason}"
            )
    except requests.Timeout:
        logger.exception("Request Timed Out")
        raise HttpsError(code=FunctionsErrorCode.DEADLINE_EXCEEDED, message="Sessionize request timed out")
    except requests.RequestException as e:
        logger.exception(f"Connection Error: {e}")
        raise HttpsError(
            code=FunctionsErrorCode.UNAVAILABLE,
            message="Network error contacting Sessionize"
        )

    return jsonify(True)
