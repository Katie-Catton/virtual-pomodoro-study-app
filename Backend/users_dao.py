from db import db
from db import User

def get_user_by_username(username):
    return User.query.filter(User.username==username).first()

def get_user_by_session_token(session_token):
    return User.query.filter(User.session_token==session_token).first()

def get_user_by_update_token(update_token):
    return User.query.filter(User.update_token==update_token).first()

def create_user(username):
    user = get_user_by_username(username)
    if user is None:
        user = User(username)
        db.session.add(user)
        db.session.commit()
    return user