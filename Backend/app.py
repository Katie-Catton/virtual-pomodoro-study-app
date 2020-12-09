from flask import Flask, render_template
from opentok import OpenTok
import os
from db import Session, User
import helper

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



#Create a session and add creator to session
@app.route("/session/", ["POST"])
def create_session(user_id):
    #Get user by auth token? 
    # user = get_user_by_session_token(session_token)
    if user is None:
        failure_response("Invalid user")
    #Create new session in OpenTok
    session = opentok.create_session()
    key = api_key
    session_id = session.session_id
    token = opentok.generate_token(session_id)

    #Create new Session Object 
    new_session = Session(session_id=session_id)
    #Add creator to Session Object
    new_session.append(user)
    #Push changes to database
    db.session.add(new_session)
    db.session.commit()

    #Gve client parameters necessary to connect
    return success_response({
        'key': api_key,
        'session_id': session_id,
        'token': token 
    })

@app.route("/session/", ["DELETE"])
def delete_session(session_id):


if __name__ == "__main__":
    app.debug = True
    app.run()