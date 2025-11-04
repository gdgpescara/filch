from firebase_functions.https_fn import on_call, CallableRequest, HttpsError, FunctionsErrorCode
from google.cloud.firestore import SERVER_TIMESTAMP
import datetime, random, json

from features.quests.types.quest_type_enum import QuestTypeEnum
from features.quests.types.quest import Quest
from features.quests.types.quest_sub_type_enum import QuestSubTypeEnum
from features.quests.types.localized_field import LocalizedField
from features.quests.types.active_quest import ActiveQuest
from features.quests.prompt_functions import prompt_functions_list
from features.points.types.points_type_enum import PointsTypeEnum
from shared.env import FIREBASE_REGION, COLLECTION_CONFIGURATIONS, COLLECTION_QUEST, SUBCOLLECTION_QUEUE, \
    DOCUMENT_FEATURE_FLAG, COLLECTION_USER, SUBCOLLECTION_POINT, SUBCOLLECTION_REMOVED_QUEST
from logger_config import logger
from firestore_client import client as firestore_client
from shared.get_signed_in_user import get_signed_in_user


@on_call(region=FIREBASE_REGION)
def search_for_quest(request: CallableRequest):
    logged_user = get_signed_in_user(request=request)

    config = firestore_client.collection(COLLECTION_CONFIGURATIONS).document(DOCUMENT_FEATURE_FLAG).get()
    config = config.to_dict() if config.exists else {}

    actor_quest_enabled = config.get('actorQuestEnabled', True)
    quiz_quest_enabled = config.get('quizQuestEnabled', True)
    community_quest_enabled = config.get('communityQuestEnabled', True)
    social_quest_enabled = config.get('socialQuestEnabled', True)

    quest_search_functions = [
        {
            "type": QuestTypeEnum.ACTOR,
            "enabled": actor_quest_enabled,
            "search_fn": search_for_actor_quest,
        },
        {
            "type": QuestTypeEnum.QUIZ,
            "enabled": quiz_quest_enabled,
            "search_fn": search_for_quiz_quest,
        },
        {
            "type": QuestTypeEnum.COMMUNITY,
            "enabled": community_quest_enabled,
            "search_fn": search_for_community_quest,
        },
        {
            "type": QuestTypeEnum.SOCIAL,
            "enabled": social_quest_enabled,
            "search_fn": search_for_social_quest,
        },
    ]

    logger.info("Quests order: " + json.dumps([q["type"] for q in quest_search_functions]))
    logger.info(f"Can search for actor quest: {actor_quest_enabled}")
    logger.info(f"Can search for quiz quest: {quiz_quest_enabled}")
    logger.info(f"Can search for community quest: {community_quest_enabled}")
    logger.info(f"Can search for social quest: {social_quest_enabled}")

    user_points_snap = firestore_client.collection(COLLECTION_USER).document(logged_user.uid).collection(
        SUBCOLLECTION_POINT).get()
    user_quest_points = [doc.to_dict().get("quest") for doc in user_points_snap if
                         doc.to_dict().get("type") == PointsTypeEnum.quest and doc.to_dict().get("quest")]
    removed_quests_snap = firestore_client.collection(COLLECTION_USER).document(logged_user.uid).collection(
        SUBCOLLECTION_REMOVED_QUEST).get()
    removed_quests = [doc.id for doc in removed_quests_snap]
    logger.debug("Removed quests: " + json.dumps(removed_quests))

    quest_found: ActiveQuest = None
    for quest_config in quest_search_functions:
        if quest_found:
            break
        if quest_config["enabled"]:
            quest_found = quest_config["search_fn"](logged_user, user_quest_points, removed_quests)

    if not quest_found:
        raise HttpsError(FunctionsErrorCode.NOT_FOUND, "No quest found")

    logger.info("Setting quest to user")
    firestore_client.collection(COLLECTION_USER).document(logged_user.uid).update(
        {"activeQuest": quest_found.model_dump()})

    if quest_found.quest.type == QuestTypeEnum.ACTOR:
        logger.info("Adding user to queue")
        firestore_client.collection(COLLECTION_QUEST).document(quest_found.quest.id).collection(
            SUBCOLLECTION_QUEUE).document(logged_user.uid).set(
            {"userId": logged_user.uid, 'queuedAt': SERVER_TIMESTAMP})

        queue_count = firestore_client.collection(COLLECTION_QUEST).document(quest_found.quest.id).collection(
            SUBCOLLECTION_QUEUE).get()
        firestore_client.collection(COLLECTION_QUEST).document(quest_found.quest.id).update(
            {'queueCount': queue_count[0].value})

        logger.info(f"Finish, quest found is: {quest_found.model_dump()}")


def search_for_actor_quest(logged_user, user_quest_points, removed_quests):
    logger.info("Searching for actor quest")
    actor_quests_snapshot = firestore_client.collection(COLLECTION_QUEST).where('type', '==',
                                                                                QuestTypeEnum.ACTOR).where(
        "requestAccepted", "==", True).get()
    now = datetime.datetime.now(datetime.UTC)
    actor_quests = []

    for doc in actor_quests_snapshot:
        data = doc.to_dict()

        validity_start = data.get("validityStart")
        validity_end = data.get("validityEnd")
        queue_count = data.get("queueCount")
        max_queue = data.get("maxQueue")

        is_valid_now = validity_start <= now and validity_end > now
        has_queue_space = not queue_count or queue_count < max_queue
        not_removed = doc.id not in removed_quests
        not_too_many_points = user_quest_points.count(doc.id) <= 3

        if is_valid_now and has_queue_space and not_removed and not_too_many_points:
            actor_quests.append(doc)

    actor_quests_len = len(actor_quests)
    logger.info(f'Found {actor_quests_len} actor quests')
    if actor_quests_len > 0:
        logger.info("Actor quest found")
        quest_snap = min(actor_quests, key=lambda doc: doc.to_dict().get("queueCount") or 0)
        quest_data = quest_snap.to_dict()
        quest_data["id"] = quest_snap.id
        quest = Quest(**quest_data)

        prompt: LocalizedField = None
        if quest.sub_type == QuestSubTypeEnum.PROMPTED and quest.prompt_function:
            logger.info(
                f"Found prompted actor quest, trying to get prompt from: {quest.prompt_function}"
            )

            prompt_fn = prompt_functions_list.get(quest.prompt_function)
            if prompt_fn:
                prompt = prompt_fn()
            else:
                logger.warning(f"Prompt function '{quest.prompt_function}' not found.")

        active_quest = ActiveQuest(quest=quest, activated_at=SERVER_TIMESTAMP)

        if prompt:
            active_quest.prompt = prompt

        return active_quest
    return None


def search_for_quiz_quest(logged_user, user_quest_points, removed_quests):
    logger.info("Searching for quiz quest")
    quiz_quests_snapshot = firestore_client.collection(COLLECTION_QUEST).where("type", "==", QuestTypeEnum.QUIZ).get()

    now = datetime.datetime.now(datetime.UTC)
    quiz_quests = []
    for doc in quiz_quests_snapshot:
        data = doc.to_dict()

        validity_start = data.get("validityStart")
        validity_end = data.get("validityEnd")
        parent_quests = data.get("parentQuests")

        is_valid_now = (
                validity_start is not None
                and validity_end is not None
                and validity_start <= now < validity_end
        )

        not_already_done = doc.id not in user_quest_points
        not_removed = doc.id not in removed_quests

        valid = is_valid_now and not_already_done and not_removed

        if not parent_quests:
            if valid:
                quiz_quests.append(doc)
            continue

        all_parents_done = all(
            parent_id in user_quest_points for parent_id in parent_quests
        )

        if valid and all_parents_done:
            quiz_quests.append(doc)

    logger.info(f"Found {len(quiz_quests)} quiz quests")
    if quiz_quests:
        logger.info("Quiz quest found")
        random_index = random.randint(0, len(quiz_quests) - 1)
        quest_snap = quiz_quests[random_index]
        quest_data = quest_snap.to_dict()
        quest_data["id"] = quest_snap.id
        quest = Quest(**quest_data)

        active_quest = ActiveQuest(quest=quest, activated_at=SERVER_TIMESTAMP)

        return active_quest

    return None


def search_for_community_quest(logged_user, user_quest_points, removed_quests):
    logger.info("Searching for community quest")
    community_quests_snapshot = firestore_client.collection(COLLECTION_QUEST).where("type", "==",
                                                                                    QuestTypeEnum.COMMUNITY).where(
        "requestAccepted", "==", True).get()

    now = datetime.datetime.now(datetime.UTC)
    community_quests = []
    for doc in community_quests_snapshot:
        data = doc.to_dict()
        validity_start = data.get("validityStart")
        validity_end = data.get("validityEnd")

        is_valid_now = (
                validity_start is not None
                and validity_end is not None
                and validity_start <= now < validity_end
        )
        not_already_done = doc.id not in user_quest_points
        not_removed = doc.id not in removed_quests

        if is_valid_now and not_already_done and not_removed:
            community_quests.append(doc)

    logger.info(f"Found {len(community_quests)} community quests")

    if community_quests:
        logger.info("Community quest found")
        quest_snap = random.choice(community_quests)
        quest_data = quest_snap.to_dict()
        quest_data["id"] = quest_snap.id
        quest = Quest(**quest_data)
        active_quest = ActiveQuest(quest=quest, activated_at=SERVER_TIMESTAMP)
        return active_quest
    return None


def search_for_social_quest(logged_user, user_quest_points, removed_quests):
    logger.info("Searching for social quest")
    social_quests_snapshot = firestore_client.collection(COLLECTION_QUEST).where("type", "==", QuestTypeEnum.COMMUNITY).where("requestAccepted", "==", True).get()

    now = datetime.datetime.now(datetime.UTC)
    social_quests = []
    for doc in social_quests_snapshot:
        data = doc.to_dict()
        validity_start = data.get("validityStart")
        validity_end = data.get("validityEnd")

        is_valid_now = (
                validity_start is not None
                and validity_end is not None
                and validity_start <= now < validity_end
        )

        not_removed = doc.id not in removed_quests

        if is_valid_now and not_removed:
            social_quests.append(doc)

    logger.info(f"Found {len(social_quests_snapshot)} social quests")
    if social_quests:
        logger.info("Social quest found")
        quest_snap = random.choice(social_quests)
        quest_data = quest_snap.to_dict()
        quest_data["id"] = quest_snap.id
        quest = Quest(**quest_data)
        active_quest = ActiveQuest(quest=quest, activated_at=SERVER_TIMESTAMP)
        return active_quest
    return None
