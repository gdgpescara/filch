from pydantic import BaseModel


class Delay(BaseModel):
    roomId: int
    delay: int