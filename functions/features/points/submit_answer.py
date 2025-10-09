from firebase_functions.https_fn import on_call, CallableRequest, HttpsError, FunctionsErrorCode
from google.cloud.firestore import SERVER_TIMESTAMP

from features.points.types.points import Points
from features.points.types.points_type_enum import PointsTypeEnum
from features.quests.types.quest import Quest
from features.quests.types.answer import Answer
from shared.get_signed_in_user import get_signed_in_user
from firestore_client import client as firestore_client
from logger_config import logger
from shared.env import FIREBASE_REGION


@on_call(region=FIREBASE_REGION)
def submit_answer(request: CallableRequest) -> bool:
    logged_user = get_signed_in_user(request)

    quest_id = request.data.get("quest")
    answers = [int(ans) for ans in request.data.get("answers", [])]

    quest_snap = (firestore_client
                  .collection("quests")
                  .document(quest_id)
                  .get())
    if not quest_snap.exists:
        raise HttpsError(code=FunctionsErrorCode.NOT_FOUND, message="Quest not found")

    quest_data = quest_snap.to_dict()
    quest_data["id"] = quest_snap.id

    if quest_data.get("answers", None) is not None:
        quest_data["answers"] = [Answer(**ans) for ans in quest_data["answers"]]

    quest = Quest.model_validate(quest_data)

    logger.info(f"Quest answers: {quest.id}")

    correct_answers = []
    if quest.answers is not None:
        correct_answers = [answer["id"] for answer in quest.answers if answer.get("isCorrect")]

    if len(correct_answers) == 0:
        raise HttpsError(code=FunctionsErrorCode.NOT_FOUND, message="Quest has no correct answers")

    logger.info(f"Correct answers: {correct_answers}")

    is_correct = all(e in answers for e in correct_answers)
    logger.info(f"Is correct: {is_correct}")

    archived_points = Points(
        type=PointsTypeEnum.quest, 
        quest=quest.id,
        assignedBy=logged_user.email,
        points=quest.points[0],
        assignedAt=SERVER_TIMESTAMP
    )

    batch = firestore_client.batch()
    if is_correct:
        doc_ref = (
            firestore_client
            .collection("users")
            .document(logged_user.uid)
            .collection("points")
            .document(quest.id)
        )

        batch.set(doc_ref, archived_points.model_dump())

    user_ref = firestore_client.collection("users").document(logged_user.uid)
    batch.update(user_ref, {"activeQuest": None})

    batch.commit()

    return is_correct
