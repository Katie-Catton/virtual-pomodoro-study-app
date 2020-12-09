#Get user by id
def get_user_by_id(user_id):
    return User.query.filter(id == user_id).first()

#Get session by id 
def get_session_by_id(session_id):
    return Session.query.filter(session_id == session_id).first()