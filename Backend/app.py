from flask import Flask, render_template, request 
from opentok import OpenTok
import os
from db import Room, User, db
import helper
import json
from google.oauth2 import id_token
from google.auth.transport import requests
from dotenv import load_dotenv
load_dotenv()
try:
    api_key = os.environ.get('API_KEY')
    api_secret = os.environ.get('API_SECRET')
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


# Responses
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


@app.route("/")


# Get rooms
@app.route("/rooms/")
def get_rooms():
    return success_response([room.serialize() for room in Room.query.all()])


# Get room
@app.route("/rooms/<string:code>/")
def get_room(code):
    room = Room.query.filter_by(code=code).first()
    if room is None:
        return failure_response("Room code invalid")
    else:
        return success_response(room.serialize())


# Create room and add creator to session
@app.route("/rooms/", methods=["POST"])
def create_session():
    body = json.loads(request.data)

    num_sessions = body.get("num_sessions")
    work_length = body.get("work_length")
    break_length = body.get("break_length")
    
    user = User.query.filter_by(user_id=body.get('user_id')).first()
    
    if user is None:
        failure_response("User invalid")
    if num_sessions is None:
        failure_response("Must enter number of sessions")
    if work_length is None:
        failure_response("Must enter length of work periods")
    if break_length is None:
        failure_response("Must enter length of break periods")

    # Create new OpenTok session
    opentok_id = opentok.create_session().session_id
    token = opentok.generate_token(opentok_id)

    # Create new Room Object 
    body = json.loads(request.data)
    new_room = Room(opentok_id=opentok_id, 
                    code=body.get('code'),
                    num_sessions=body.get('num_sessions'),
                    work_length=body.get('work_length'),
                    break_length=body.get('break_length')
                    )

    # Add creator to Room Object
    new_room.users.append(user)

    # Push changes to database
    db.session.add(new_room)
    db.session.commit()

    # Give client parameters necessary to connect
    return success_response({
        'key': api_key,
        'opentok_id': opentok_id,
        'token': token 
    }, 201)


# Delete room
@app.route("/rooms/<string:code>/", methods=["DELETE"])
def delete_room(code):
    room = Room.query.filter_by(code=code).first()
    if room is None:
        return failure_response("Room code invalid")
    else:
        db.session.delete(room)
        db.session.commit()
        return success_response(room.serialize())


# User signs in
@app.route("/signin/", methods=["POST"])
def sign_in():
    body = json.loads(request.data)
    token = body.get('user_token')
    try:
        # Specify the CLIENT_ID of the app that accesses the backend
        id_info = id_token.verify_oauth2_token(token, requests.Request(), CLIENT_ID)
        user_id = id_info['sub']
        user = User.query.filter_by(user_id=user_id).first()
        if user is None:
            user = User(user_id)
            db.session.add(user)
            db.session.commit()
        data = json.dumps({
            "session_token": user.session_token,
            "session_expiration": str(user.session_expiration),
            "update_token": user.update_token
           })
        return success_response(data, 201)
    except Exception:
        return failure_response("User invalid")


# User joins a room
@app.route("/join/", methods=["POST"])
def join_session():
    body = json.loads(request.data)
    code = body.get('code')
    user = User.query.filter_by(user_id=body.get('user_id')).first()
    room = Room.query.filter_by(code=code).first()

    token = opentok.generate_token(room.opentok_id,
                                    expire_time=int(time.time()) + room.room_length)
    
    if room is not None:
        if user is not None:
            room.users.append(user)
            return success_response({
                'key': api_key,
                'opentok_id': room.opentok_id,
                'token': token 
            })
        else:
            return failure_response("User id invalid")
    else:
        return failure_response("Room id invalid")


### Only necessary for testing ###

# Create user
@app.route("/users/", methods = ["POST"])
def create_user():
    body = json.loads(request.data)
    user = User(user_id=body.get('user_id'))
    db.session.add(user)
    db.session.commit()
    return success_response(user.serialize())


if __name__ == "__main__":
    port = int(os.environ.get("PORT",5000))
    app.run(host="0.0.0.0", port=port)