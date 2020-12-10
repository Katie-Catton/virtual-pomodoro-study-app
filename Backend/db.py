import datetime
import hashlib
import os

import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    session_id = db.Column(db.Integer, db.ForeignKey('room.id'), nullable = True)


    # Session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    def __init__(self, **kwargs):
        self.user_id = kwargs.get('user_id')
        self.session_id = None 
        self.renew_session()

    def serialize(self):
        return {
            "user_id": self.user_id
        }
    def _urlsafe_base_64(self):
        return hashlib.sha1(os.urandom(64)).hexdigest()

    # Generates new tokens, and resets expiration time
    def renew_session(self):
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    # Checks if session token is valid and hasn't expired
    def verify_session_token(self, session_token):
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        return update_token == self.update_token

class Room(db.Model):
    __tablename__ = 'room'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String, nullable=False)
    session_id = db.Column(db.Integer, nullable=False)
    users = db.relationship('User', cascade=False)

    def __init__(self, **kwargs):
        self.session_id = kwargs.get('session_id')
        self.code = kwargs.get('code')
    
    def serialize(self):
        return {
            'session_id': self.session_id,
            'code': self.code,
            'users': [user.serialize() for user in self.users]
        }


    