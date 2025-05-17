from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class Points(BaseModel):
    """Model representing points assigned to a user."""
    type: str
    points: int
    assigned_by: str
    assigned_at: datetime
    quest: Optional[str] = None
