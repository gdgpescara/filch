from pydantic import BaseModel
from typing import List


class NamedEntity(BaseModel):
    id: int
    name: str


class Session(BaseModel):
    id: str
    title: str
    description: str
    startsAt: str
    endsAt: str
    speakers: List[str]
    roomId: int
    room: str
    sessionFormat: NamedEntity
    tracks: List[NamedEntity]
    level: NamedEntity
    language: NamedEntity
