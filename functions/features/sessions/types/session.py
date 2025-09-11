from pydantic import BaseModel
from typing import List, Optional
from features.speakers.types.speaker import Social


class NamedEntity(BaseModel):
    id: int
    name: str

class SessionSpeaker(BaseModel):
    id: str
    name: str
    bio: Optional[str]
    profilePicture: Optional[str]
    links: List[Social]
    tagLine: Optional[str]

class Session(BaseModel):
    id: str
    title: str
    description: Optional[str]
    startsAt: str
    endsAt: str
    speakers: List[SessionSpeaker]
    room: Optional[NamedEntity]
    sessionFormat: Optional[NamedEntity]
    tracks: List[NamedEntity]
    tags: List[NamedEntity]
    level: Optional[NamedEntity]
    language: Optional[NamedEntity]
    isServiceSession: Optional[bool] = False
