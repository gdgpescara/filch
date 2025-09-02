"""
Environment variables and configuration settings for the application.
"""
import os

# Firebase region for cloud functions
# Retrieve from environment variables, with a default fallback
FIREBASE_REGION = os.environ.get("FIREBASE_REGION", "europe-west3")
SESSIONIZE_EVENT_ID = os.environ.get("SESSIONIZE_EVENT_ID", None)
