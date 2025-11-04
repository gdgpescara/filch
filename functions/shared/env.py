"""
Environment variables and configuration settings for the application.
"""
import os

# TODO Possibile spostare alcuni valori su DB
START_DAY = 8
END_DAY = 9
MONTH = 11
START_HOUR = 10
END_HOUR = 18
FIREBASE_REGION = os.environ.get("FIREBASE_REGION", "europe-west3")
SESSIONIZE_EVENT_ID = os.environ.get("SESSIONIZE_EVENT_ID", None)
TZ = 'Europe/Rome'

# SCAN QUEST
ASSIGN_POINT_EVERY = 1
GET_POINTS_FROM_DB = False
POINTS_AFTER_SCAN = 10
MAX_TIMES_ASSIGNMENT = 9999

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
SUBCOLLECTION_REMOVED_QUEST = 'removed_quests'

# DOCUMENTS
DOCUMENT_PROMPT = "prompts"
DOCUMENT_TSHIRT = "t-shirt"
DOCUMENT_FEATURE_FLAG = 'feature_flags'



