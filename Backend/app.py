from flask import Flask, render_template, request 
from opentok import OpenTok
import os
from db import Room, User, db
import helper
import json
#from google.oauth2 import id_token
#from google.auth.transport import requests


try:
    os.environ['API_KEY'] = '47019364'
    os.environ['API_SECRET'] = '02170d486e83efebec4ff23408a8958278b59cb6'
    api_key = os.environ['API_KEY']
    api_secret = os.environ['API_SECRET']
except Exception:
    raise Exception('You must define API_KEY and API_SECRET environment variables')


db_filename = "pomodoro.db"
app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()
opentok = OpenTok(api_key, api_secret)
#Responses
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


@app.route("/")

@app.route("/users/",methods = ["POST"])
def create_user():
    body = json.loads(request.data)
    user = User(user_id=body.get('user_id'))
    db.session.add(user)
    db.session.commit()
    return success_response(user.serialize())


#Get a session
@app.route("/session/<string:code>/")
def get_session(code):
    session = Room.query.filter_by(code=code).first()
    if session is None:
        return failure_response("Room code invalid")
    else:
        return success_response(session.serialize())


#Create a session and add creator to session
@app.route("/session/<int:user_id>/", methods=["POST"])
def create_session(user_id):
    user = User.query.filter_by(user_id=user_id).first()
    if user is None:
        failure_response("Invalid user")

    #Create new session in OpenTok
    session = opentok.create_session()
    session_id = session.session_id
    token = opentok.generate_token(session_id)

    #Create new Session Object 
    body = json.loads(request.data)
    new_session = Room(session_id=session_id, code=body.get('code'))
    #Add creator to Session Object
    new_session.users.append(user)
    #Push changes to database
    db.session.add(new_session)
    db.session.commit()

    #Give client parameters necessary to connect
    return success_response({
        'key': api_key,
        'session_id': session_id,
        'token': token 
    })


@app.route("/session/<string:code>/", methods=["DELETE"])
def delete_session(code):
    session = Room.query.filter_by(code=code).first()
    if session is None:
        return failure_response("Session code invalid")
    else:
        db.session.delete(session)
        db.session.commit()
        return success_response(session.serialize())


# @app.route("/signin", methods=["POST"])
# def sign_in():
#     body = json.loads(request.data)
#     token = body.get('user_token')
#     try:
#         # Specify the CLIENT_ID of the app that accesses the backend
#         id_info = id_token.verify_oauth2_token(token, requests.Request(), CLIENT_ID)
#         user_id = id_info['sub']
#         user = User.query.filter_by(user_id=user_id).first()
#         if user is None:
#             user = 

# @app.route("/join/")
# def join_session(code):
#     session = Session.query.filter_by(code=code).first()
#     if session is not None:

#@app.route("/login/", methods=["POST"])
#def login():
#    body = json.loads(request.data)
#    email = body.get("email")
#   password = body.get("password")
#    if email is None  or password is None:
#       return json.dumps({"error": "Invalid email or password"})

#    was_success, user = users_dao.verify_credentials(email,password)

#    if not was_success:
#        return json.dumps({"error": "Incorrect email/password"})
    
#    return json.dumps({
#        "session_token":user.session_token,
#        "session_expiration": str(user.session_expiration),
#        "update_token": user.update_token

#    })



if __name__ == "__main__":
    app.debug = True
    app.run()