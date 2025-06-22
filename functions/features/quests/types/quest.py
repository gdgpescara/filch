from typing import List, Optional
from pydantic import BaseModel

from features.quests.types.quest_type_enum import QuestTypeEnum
from features.quests.types.quest_sub_type_enum import QuestSubTypeEnum
from features.quests.types.answer import Answer
from features.quests.types.localized_field import LocalizedField
from features.quests.prompt_functions import PromptFunctions
from datetime import datetime


class Quest(BaseModel):
    id: str
    title: Optional[LocalizedField] = None
    description: LocalizedField
    points: List[int]
    validityStart: datetime
    validityEnd: datetime
    executionTime: int
    type: QuestTypeEnum
    subType: Optional[QuestSubTypeEnum] = None

    # Actor & community quest section
    queueTime: Optional[int] = None
    actor: Optional[str] = None
    maxQueue: Optional[int] = None
    groupSize: Optional[int] = None
    requestAccepted: Optional[bool] = None
    promptFunction: Optional[PromptFunctions] = None

    # Quiz quest section
    parentQuests: Optional[List[str]] = None
    qrCode: Optional[str] = None
    question: Optional[LocalizedField] = None
    answers: Optional[List[Answer]] = None

    # Social quest section
    verificationFunction: Optional[str] = None
