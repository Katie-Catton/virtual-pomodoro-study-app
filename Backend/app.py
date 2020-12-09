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
def hello():
    key = api_key
    session_id = session.session_id
    token = opentok.generate_token(session_id)
    return render_template('index.html', api_key=key, session_id=session_id, token=token)

#Create a session and add creator to session
#Might Change this from using user_id in route to not, depending on how we want to handle 
@app.route("/session/<int:user_id>/", ["POST"])
def create_session(user_id):
    user = helper.get_user_by_id(user_id)
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

@app.route("/session/<int:session_id>/")


if __name__ == "__main__":
    app.debug = True
    app.run()