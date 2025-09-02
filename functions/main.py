# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_functions.options import set_global_options
from firebase_admin import initialize_app, credentials

# For cost control, you can set the maximum number of containers that can be
# running at the same time. This helps mitigate the impact of unexpected
# traffic spikes by instead downgrading performance. This limit is a per-function
# limit. You can override the limit for each function using the max_instances
# parameter in the decorator, e.g. @https_fn.on_request(max_instances=5).
set_global_options(max_instances=10, memory=512, timeout_sec=300)

initialize_app()

from features.user.t_shirt_pickup import t_shirt_pickup
from features.user.t_shirt_notification import t_shirt_notification_schedule


from features.points.scan_other_attendee import scan_other_attendee
# from features.points.points_manager import user_points_sentinel
from features.points.submit_answer import submit_answer
from features.points.assign_points import assign_points
from features.sessions.fetch_from_sessionize import fetch_sessions
from features.speakers.fetch_from_sessionize import fetch_speakers