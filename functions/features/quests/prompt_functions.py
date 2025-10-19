from enum import Enum
from typing import List
import random

from firestore_client import client as firestore_client
from logger_config import logger
from features.quests.types.localized_field import LocalizedField

COLLECTION_CONFIGURATIONS = "configurations"


async def love_words() -> LocalizedField:
    config = firestore_client.collection(COLLECTION_CONFIGURATIONS).document("prompts").get().to_dict()

    logger.info(f"prompts found: {config}")

    love_words_list: List[LocalizedField] = config.get("loveWords", [])
    picked_words = random.sample(love_words_list, min(5, len(love_words_list)))

    first_word = picked_words[0]
    rest_words = picked_words[1:]

    combined: LocalizedField = first_word.copy()
    for word in rest_words:
        for key, value in word.items():
            combined[key] = combined.get(key, "") + "\n" + value

    return combined


class PromptFunctions(str, Enum):
    LOVE_WORDS = "loveWords"


prompt_functions_list = {
    PromptFunctions.LOVE_WORDS: love_words
}
