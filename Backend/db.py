from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User:
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            'user_id': user_id
        }
  

class Session:
    __tablename__ = 'session'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String, nullable=False)
    session_id = db.Column(db.Integer, nullable=False)
    users = db.relationship('user', cascade=False)

    def __init__(self, **kwargs):
        self.session_id = kwargs.get('session_id')
        self.code = kwargs.get('code')
    
    def serialize(self):
        return {
            'session_id': self.session_id,
            'code': self.code,
            'users': [user.serialize() for user in users]
        }


    