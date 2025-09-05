from pydantic import BaseModel
from typing import List, Optional


class NamedEntity(BaseModel):
    id: int
    name: str


class SessionSpeaker(BaseModel):
    id: str
    name: str
    profilePicture: Optional[str]


class Session(BaseModel):
    id: str
    title: str
    description: str
    startsAt: str
    endsAt: str
    speakers: List[SessionSpeaker]
    roomId: int
    room: str
    sessionFormat: NamedEntity
    tracks: List[NamedEntity]
    level: NamedEntity
    language: NamedEntity
