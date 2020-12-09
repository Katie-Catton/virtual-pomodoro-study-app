from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User:
    __tablename__ = 'user'
    

class Session:
    __tablename__ = 'session'
    id = db.Column(db.Integer, primary_key=True)
    session_id = db.Column(db.Integer, nullable=False)
