from db import User, Room

#Get user by id
def get_user_by_id(user_id):
    return User.query.filter(id == user_id).first()

#Get room by id 
def get_room_by_id(room_id):
    return Room.query.filter(id == room_id).first()