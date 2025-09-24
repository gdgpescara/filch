from features.rooms.types.room import Room
from features.sessions.types.session import Session


def infer_rooms_from_sessions(sessions: list[Session]) -> list[Room]:
    rooms_by_id = {
        session.room.id: Room(id=session.room.id, name=session.room.name)
        for session in sessions
        if session.room is not None
    }
    return list(rooms_by_id.values())
