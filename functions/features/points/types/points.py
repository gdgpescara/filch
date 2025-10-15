from typing import Optional, Any
from pydantic import BaseModel


class Points(BaseModel):
    type: str
    points: int
    assignedBy: Optional[str] = None
    assignedAt: Any
    quest: Optional[str] = None
