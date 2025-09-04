# This file makes the 'shared' directory a Python package
# Export the get_signed_in_user function so it can be imported from 'shared'
from .get_signed_in_user import get_signed_in_user

__all__ = ['get_signed_in_user']
