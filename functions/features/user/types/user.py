from datetime import datetime
from typing import Optional, Dict, Any


class User(BaseModel):
    uid: str
    email: str
    display_name: Optional[str] = None
    photo_url: Optional[str] = None
    language: str = "en"
    created_at: datetime = None
    staff: bool = False
    sponsor: bool = False
    t_shirt_pickup: bool = False
    t_shirt_pickup_requested: bool = False
    fcm_token: Optional[str] = None
    points: int = 0
