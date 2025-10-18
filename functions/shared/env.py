"""
Environment variables and configuration settings for the application.
"""
import os

FIREBASE_REGION = os.environ.get("FIREBASE_REGION", "europe-west3")
SESSIONIZE_EVENT_ID = os.environ.get("SESSIONIZE_EVENT_ID", None)
