from firebase_functions.https_fn import HttpsError, FunctionsErrorCode
from typing import List
from features.sessions.types.session import Session, NamedEntity, SessionSpeaker
from logger_config import logger
import json, requests


def transform_sessions(raw_data: list) -> List[Session]:
    category_handlers = {
        "Session format": lambda items: ("sessionFormat", NamedEntity(id=items[0]["id"], name=items[0]["name"])),
        "Track": lambda items: ("tracks", [NamedEntity(id=item["id"], name=item["name"]) for item in items]),
        "Level": lambda items: ("level", NamedEntity(id=items[0]["id"], name=items[0]["name"])),
        "Language": lambda items: ("language", NamedEntity(id=items[0]["id"], name=items[0]["name"])),
        "Tags": lambda items: ("tags", [NamedEntity(id=item["id"], name=item["name"]) for item in items])
    }

    result = []
    for group in raw_data:
        for session in group.get("sessions", []):
            title = session.get("title", "")
            description = session.get("description", "")
            roomId = session.get("roomId")
            roomName = session.get("room")
            startsAt = session.get("startsAt")
            endsAt = session.get("endsAt")

            if roomId is None or roomName is None or startsAt is None or endsAt is None:
                logger.info(f"Missing session information for session '{session.get('id')}'. Skipping.")
                continue

            pp_session = {
                "id": session.get("id"),
                "title": title,
                "description": description,
                "startsAt": startsAt,
                "endsAt": endsAt,
                "speakers": [SessionSpeaker(id=s.get("id"), name=s.get("name"), profilePicture=None) for s in session.get("speakers", [])],
                "room": NamedEntity(id=roomId, name=roomName),
                "sessionFormat": None,
                "tracks": [],
                "tags": [],
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
                logger.exception(f"Error During Session: {session.get('id')} Managing: {e}.")
                # logger.info(f"Related Info Are {json.dumps(session, indent=2, ensure_ascii=False, default=str)}")
    return result


def fetch_sessions(event_id: str) -> List[Session]:
    url = f"https://sessionize.com/api/v2/{event_id}/view/" + "Sessions"
    logger.info(f"Downloading Sessions From: {url}")
    try:
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            logger.info("Sessions JSON Fetched")
            try:
                raw_data = response.json()
                return transform_sessions(raw_data=raw_data)
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
