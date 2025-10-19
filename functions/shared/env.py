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
