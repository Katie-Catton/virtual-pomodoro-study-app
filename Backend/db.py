from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User:
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
  

class Session:
    __tablename__ = 'session'
    id = db.Column(db.Integer, primary_key=True)
    session_id = db.Column(db.Integer, nullable=False)
    users = db.relationship('user', casecade=False)

    def __init__(self, **kwargs):
        self.code = kwargs.get('session_id')

    