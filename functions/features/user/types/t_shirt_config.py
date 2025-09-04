from datetime import datetime
from typing import List, Optional


class TimeBand:
    """Represents a time period with start and end timestamps."""
    def __init__(self, start: datetime, end: datetime):
        self.start = start
        self.end = end
    
    def is_current_time_in_band(self) -> bool:
        """Check if the current time is within this time band."""
        now = datetime.now()
        return self.start.timestamp() <= now.timestamp() <= self.end.timestamp()


class TShirtConfiguration:
    """Model representing the T-shirt configuration in Firestore."""
    def __init__(
        self,
        t_shirt_pickup_enabled: bool = False,
        default_pool: int = 0,
        boost_pool: int = 0,
        boost_time_bands: List[TimeBand] = None
    ):
        self.t_shirt_pickup_enabled = t_shirt_pickup_enabled
        self.default_pool = default_pool
        self.boost_pool = boost_pool
        self.boost_time_bands = boost_time_bands or []
    
    def is_boost_time(self) -> bool:
        """Check if the current time is within any boost time band."""
        return any(band.is_current_time_in_band() for band in self.boost_time_bands)
    
    def get_current_pool_size(self) -> int:
        """Get the current pool size based on the time bands."""
        return self.boost_pool if self.is_boost_time() else self.default_pool
    
    def to_dict(self) -> dict:
        """Convert the configuration model to a dictionary for Firestore."""
        return {
            "tShirtPickupEnabled": self.t_shirt_pickup_enabled,
            "defaultPool": self.default_pool,
            "boostPool": self.boost_pool,
            "boostTimeBands": [
                {"start": band.start, "end": band.end}
                for band in self.boost_time_bands
            ]
        }
    
    @classmethod
    def from_dict(cls, data: dict):
        """Create a TShirtConfiguration model from a Firestore document."""
        if not data:
            return cls()
            
        # Convert dictionary time bands to TimeBand objects
        time_bands = []
        for band in data.get("boostTimeBands", []):
            if isinstance(band, dict) and "start" in band and "end" in band:
                time_bands.append(TimeBand(
                    start=band["start"],
                    end=band["end"]
                ))
                
        return cls(
            t_shirt_pickup_enabled=data.get("tShirtPickupEnabled", False),
            default_pool=data.get("defaultPool", 0),
            boost_pool=data.get("boostPool", 0),
            boost_time_bands=time_bands
        )
