from typing import TypedDict

from features.quests.types.localized_field import LocalizedField


class Answer(TypedDict):
    id: int
    text: LocalizedField
    isCorrect: bool
