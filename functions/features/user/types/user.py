from datetime import datetime
from typing import Optional, Dict, Any


class User:
    """Model representing a user in the application."""
    def __init__(
        self,
        uid: str,
        email: str,
        display_name: Optional[str] = None,
        photo_url: Optional[str] = None,
        language: str = "en",
        created_at: datetime = None,
        is_staff: bool = False,
        t_shirt_pickup: bool = False,
        t_shirt_pickup_requested: bool = False,
        fcm_token: Optional[str] = None,
        points: int = 0
    ):
        self.uid = uid
        self.display_name = display_name
        self.email = email
        self.photo_url = photo_url
        self.language = language
        self.created_at = created_at or datetime.now()
        self.is_staff = is_staff
        self.t_shirt_pickup = t_shirt_pickup
        self.t_shirt_pickup_requested = t_shirt_pickup_requested
        self.fcm_token = fcm_token
        self.points = points
    
    def to_dict(self) -> dict:
        """Convert the User model to a dictionary for Firestore."""
        return {
            "displayName": self.display_name,
            "email": self.email,
            "photoUrl": self.photo_url,
            "language": self.language,
            "createdAt": self.created_at,
            "isStaff": self.is_staff,
            "tShirtPickup": self.t_shirt_pickup,
            "tShirtPickupRequested": self.t_shirt_pickup_requested,
            "fcmToken": self.fcm_token,
            "points": self.points,
        }
    
    @classmethod
    def from_auth_user(cls, auth_user):
        """Create a User model from a Firebase Auth user."""
        return cls(
            uid=auth_user.uid,
            display_name=auth_user.display_name,
            email=auth_user.email,
            photo_url=auth_user.photo_url,
            language=auth_user.language,
            created_at=auth_user.metadata.creation_time,
            is_staff=False,
            t_shirt_pickup=False,
            t_shirt_pickup_requested=False,
            fcm_token=None,
            points=0,
        )
    
    @classmethod
    def from_dict(cls, uid: str, data: dict):
        """Create a User model from a Firestore document."""
        return cls(
            uid=uid,
            display_name=data.get("displayName"),
            email=data.get("email"),
            photo_url=data.get("photoUrl"),
            language=data.get("language"),
            created_at=data.get("createdAt"),
            is_staff=data.get("isStaff", False),
            t_shirt_pickup=data.get("tShirtPickup", False),
            t_shirt_pickup_requested=data.get("tShirtPickupRequested", False),
            fcm_token=data.get("fcmToken"),
            points=data.get("points", 0),
        )
