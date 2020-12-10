from flask import Flask, render_template
from opentok import OpenTok
import os
from db import Session, User
import helper
from google.oauth2 import id_token
from google.auth.transport import requests

try:
    os.environ['API_KEY'] = '47019364'
    os.environ['API_SECRET'] = '02170d486e83efebec4ff23408a8958278b59cb6'
    api_key = os.environ['API_KEY']
    api_secret = os.environ['API_SECRET']
except Exception:
    raise Exception('You must define API_KEY and API_SECRET environment variables')

app = Flask(__name__)
opentok = OpenTok(api_key, api_secret)
#Responses
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


@app.route("/")

#Get a session
@app.route("/session/<int:session_id>/")
def get_session(session_id):
    session = Session.query.filter_by(session_id=session_id)
    if session is None:
        return failure_response("Session id invalid")
    else:
        return success_response(session.serialize())


#Create a session and add creator to session
@app.route("/session/", methods=["POST"])
def create_session(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        failure_response("Invalid user")

    #Create new session in OpenTok
    session = opentok.create_session()
    session_id = session.session_id
    token = opentok.generate_token(session_id)

    #Create new Session Object 
    body = json.loads(request.data)
    new_session = Session(session_id=session_id, code=body.get('code'))
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


@app.route("/session/<int:session_id/", ["DELETE"])
def delete_session(session_id):
    session = Session.query.filter_by(session_id=session_id)
    if session is None:
        return failure_response("Session id invalid")
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


if __name__ == "__main__":
    app.debug = True
    app.run()