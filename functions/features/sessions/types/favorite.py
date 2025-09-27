from pydantic import BaseModel
from typing import Any, Optional


class FavoriteSession(BaseModel):
    sessionId: Optional[str] = None
    addedAt: Any