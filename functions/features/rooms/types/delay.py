from pydantic import BaseModel, ConfigDict
from typing import Any, Optional

class Delay(BaseModel):
    roomId: Optional[int] = None
    delay: Any
    updatedAt: Any
    updatedBy: str
    
    model_config = ConfigDict(exclude_none=True)
