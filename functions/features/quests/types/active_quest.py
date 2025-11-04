from pydantic import BaseModel
from typing import Any

from features.quests.types.quest import Quest
from features.quests.types.localized_field import LocalizedField


class ActiveQuest(BaseModel):
    quest: Quest
    prompt: LocalizedField
    activatedAt: Any

