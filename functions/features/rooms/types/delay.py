from pydantic import BaseModel
from typing import Any, Optional

class Delay(BaseModel):
    roomId: Optional[int] = None
    delay: Any
    updatedAt: Any
    updatedBy: str