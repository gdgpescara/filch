from firebase_admin import initialize_app

'''
from features.user.user_manager import on_user_create, on_user_delete
from features.user.t_shirt_pickup import t_shirt_pickup
from features.user.t_shirt_notification import t_shirt_notification_schedule
from features.points.points_manager import user_points_sentinel
'''

# Initialize Firebase app
initialize_app()

from features.points.scan_other_attendee import scan_other_attendee
from features.points.points_manager import user_points_sentinel
from features.points.submit_answer import submit_answer
from features.points.assign_points import assign_points

'''
# User management functions
on_user_create_function = on_user_create
on_user_delete_function = on_user_delete
t_shirt_pickup_function = t_shirt_pickup
t_shirt_notification_schedule_function = t_shirt_notification_schedule
'''


