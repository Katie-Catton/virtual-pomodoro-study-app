#Add user to session
def get_user_by_id(user_id):
    return User.query.filter(id == user_id).first()

def get_session_by_id(session_id):
    return Session.query.filter(id == session_id).first()