from enum import Enum


class QuestTypeEnum(str, Enum):
    ACTOR = "actor",
    QUIZ = "quiz",
    SOCIAL = "social",
    COMMUNITY = "community"
