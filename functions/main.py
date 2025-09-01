from firebase_admin import initialize_app

initialize_app()

# from features.user.user_manager import on_user_create, on_user_delete
from features.user.t_shirt_pickup import t_shirt_pickup
from features.user.t_shirt_notification import t_shirt_notification_schedule


from features.points.scan_other_attendee import scan_other_attendee
from features.points.points_manager import user_points_sentinel
from features.points.submit_answer import submit_answer
from features.points.assign_points import assign_points


