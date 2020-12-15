import datetime
import hashlib
import os

import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    room_id = db.Column(db.Integer, db.ForeignKey('room.id'), nullable=True)
    
    # User session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)


    def __init__(self, **kwargs):
        self.username = kwargs.get('username')
        self.room_id = None 
        self.renew_session()


    def serialize(self):
        return {
            "username": self.username
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
    opentok_id = db.Column(db.String, nullable=False)
    code = db.Column(db.String, unique=True, nullable=False)
    

    # Customizable features
    num_sessions = db.Column(db.Integer, nullable=False)
    work_length = db.Column(db.Integer, nullable=False)
    break_length = db.Column(db.Integer, nullable=False)
    paused = db.Column(db.Boolean, nullable = False)

    room_length = db.Column(db.Integer)
    users = db.relationship('User', cascade=False)


    def __init__(self, **kwargs):
        self.opentok_id = kwargs.get('opentok_id')
        self.code = kwargs.get('code')
        self.num_sessions = kwargs.get('num_sessions')
        self.work_length = kwargs.get('work_length')
        self.break_length = kwargs.get('break_length')
        self.room_length = self.num_sessions*(self.work_length+self.break_length)
        self.paused = True
    

    def serialize(self):
        return {
            'opentok_id': self.opentok_id,
            'code': self.code,
            'num_sessions': self.num_sessions,
            'work_length': self.work_length,
            'break_length': self.break_length,
            'users': [user.serialize() for user in self.users],
            'paused': self.paused
        }


    