from pydantic import BaseModel
from typing import List


class Social(BaseModel):
    title: str
    url: str


class Speaker(BaseModel):
    id: str
    firstName: str
    lastName: str
    bio: str
    profilePicture: str
    links: List[Social]
    tagLine: str
