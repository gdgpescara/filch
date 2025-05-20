from typing import Optional, Any
from pydantic import BaseModel


class Points(BaseModel):
    """Model representing points assigned to a user."""
    type: str
    points: int
    assigned_by: Optional[str] = None
    assigned_from: Optional[str] = None
    assigned_at: Any
    quest: Optional[str] = None
