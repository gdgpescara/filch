from pydantic import BaseModel
from typing import List, Optional


class Social(BaseModel):
    title: str
    url: str


class Speaker(BaseModel):
    id: str
    firstName: str
    lastName: str
    bio: str
    profilePicture: Optional[str]
    links: List[Social]
    tagLine: str
