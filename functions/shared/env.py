"""
Environment variables and configuration settings for the application.
"""
import os

START_DAY = 8
END_DAY = 9
MONTH = 11
START_HOUR = 10
END_HOUR = 18
FIREBASE_REGION = os.environ.get("FIREBASE_REGION", "europe-west3")
SESSIONIZE_EVENT_ID = os.environ.get("SESSIONIZE_EVENT_ID", None)
TZ = 'Europe/Rome'

# COLLECTIONS
COLLECTION_USER = 'users'
COLLECTION_CONFIGURATIONS = "configurations"
COLLECTION_ROOM_NAME = "rooms"
COLLECTION_DELAY_NAME = "room_delays"
COLLECTION_SESSION_NAME = 'sessions'
COLLECTION_SPEAKER_NAME = 'speakers'
COLLECTION_QUEST = "quests"
COLLECTION_TEAM = "teams"

# SUBCOLLECTIONS
SUBCOLLECTION_FAVORITE_SESSION = "favorite_sessions"
SUBCOLLECTION_POINT = "points"
SUBCOLLECTION_QUEUE = "queue"

# DOCUMENTS
DOCUMENT_PROMPT = "prompts"
DOCUMENT_TSHIRT = "t-shirt"



