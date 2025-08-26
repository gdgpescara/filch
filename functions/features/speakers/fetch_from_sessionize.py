from firestore_client import client as firestore_client
from firebase_functions.https_fn import on_request, HttpsError, FunctionsErrorCode
from typing import List
from features.speakers.types.speaker import Speaker, Social
from shared.get_signed_in_user import verify_firebase_auth
from shared.env import SESSIONIZE_EVENT_ID, FIREBASE_REGION
from logger_config import logger
import json, requests
from flask import jsonify, Request

base_url = f"https://sessionize.com/api/v2/{SESSIONIZE_EVENT_ID}/view/"


def transform_speakers(raw_data: list) -> List[Speaker]:
    result = []
    for speaker in raw_data:
        pp_speaker = {
            "id": speaker.get("id"),
            "firstName": speaker.get("firstName"),
            "lastName": speaker.get("lastName"),
            "bio": speaker.get("bio"),
            "profilePicture": speaker.get("profilePicture"),
            "tagLine": speaker.get("tagLine"),
            "links": [Social(title=s.get("title"), url=s.get("url")) for s in speaker.get("links", [])],
        }
        try:
            result.append(Speaker(**pp_speaker))
        except Exception as e:
            logger.exception(f"Error During Speaker Managing: {e}.")
            logger.info(f"Related Info Are {json.dumps(pp_speaker, indent=2, ensure_ascii=False, default=str)}")
    return result


def upload_speakers_to_firestore(speakers: List[Speaker], collection_name: str = "speaker") -> None:
    try:
        batch = firestore_client.batch()
        for session in speakers:
            doc_ref = firestore_client.collection(collection_name).document(session.id)
            session_dict = session.model_dump()
            batch.set(doc_ref, session_dict)

        batch.commit()
        logger.info(f"Uploaded {len(speakers)} sessions to Firestore.")
    except Exception as e:
        raise e


@on_request(region=FIREBASE_REGION)
def fetch_speakers(request: Request) -> bool:
    # user_info = verify_firebase_auth(request=request)
    # logger.info(f"Logged User Info: {user_info}")
    if SESSIONIZE_EVENT_ID is None:
        logger.error("Event ID not provided")
    else:
        url = base_url + "Speakers"
        logger.info(f"Downloading Speakers From: {url}")
        try:
            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                logger.info("Speakers JSON Fetched")
                try:
                    raw_data = response.json()
                    upload_speakers_to_firestore(speakers=transform_speakers(raw_data=raw_data))
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
