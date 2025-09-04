from flask import Request
from logger_config import logger
from shared.env import SESSIONIZE_EVENT_ID


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

