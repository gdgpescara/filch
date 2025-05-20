from enum import Enum


class PointsTypeEnum(Enum):
    """Enumeration of different types of points that can be assigned to users."""
    STAFF = "staff"
    COMMUNITY = "community"
    QUEST = "quest"
