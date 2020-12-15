//
//  NetworkManager.swift
//  study-app
//
//  Created by Katie Catton on 12/6/20.
//

import Foundation
import Alamofire
import GoogleSignIn

enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

class NetworkManager {
    
    private static let host = "https://virtual-pomodoro.herokuapp.com"
    
    // endpoints we need to implement:
    // /rooms/
    // GET, POST
    // query parameter /?code=string/
    // POST, DELETE
    // /signin/
    // POST
    // /join/
    // POST
    
    // /rooms/
    // GET
    static func getRoom(completion: @escaping ([Room]) -> Void) {
        let endpoint = "\(host)/rooms/"
        AF.request(endpoint, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let roomsData = try? jsonDecoder.decode(RoomResponse<Room>.self, from: data as! Data) {
                    let rooms = roomsData.data
                    completion([rooms])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //POST
    static func createRoom(username: String, code: String, numSessions: Int, workLength: Int, breakLength: Int, completion: @escaping (RoomKeys) -> Void ) {
        let parameters: [String: Any] = [
            "username": username,
            "code": code,
            "num_session": numSessions,
            "work_length": workLength,
            "break_length": breakLength
        ]
        let endpoint = "\(host)/rooms/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let room = try? jsonDecoder.decode(RoomResponse<RoomKeys>.self, from: data) {
                    let newRoom = room.data
                    completion(newRoom)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // /rooms/?code=string
    // GET
    static func getRoomCode(withQuery query: String, completion: @escaping (Room) -> Void) {
        let parameters: [String: Any] = [
            "code" : query
        ]
        let endpoint = "\(host)/rooms/?code="
        AF.request(endpoint, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let roomCode = try? jsonDecoder.decode(RoomResponse<Room>.self, from: data) {
                    let room = roomCode.data
                    completion(room)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //DELETE
    static func deleteRoom(withQuery query: String, completion: @escaping (Room) -> Void) {
        let parameters: [String: Any] = [
            "code" : query
        ]
        let endpoint = "\(host)/rooms/?code="
        AF.request(endpoint, method: .delete, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let roomCode = try? jsonDecoder.decode(RoomResponse<Room>.self, from: data) {
                    let room = roomCode.data
                    completion(room)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    // /signin/
    // POST
    static func getSession(userToken: String, completion: @escaping (SignInReponse) -> Void) {
            let parameters: [String: Any] = [
                "user_token" : userToken
            ]
            let endpoint = "\(host)/signin/"
            AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let session = try? jsonDecoder.decode(SignInReponse.self, from: data) {
                        let newSession = session
                        completion(newSession)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    // /join/
    // POST
    static func joinRoom(code: String, username: String, completion: @escaping (RoomKeys) -> Void) {
            let parameters: [String: Any] = [
                "code": code,
                "username": username
            ]
            let endpoint = "\(host)/signin/"
            AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let room = try? jsonDecoder.decode(RoomKeys.self, from: data) {
                        completion(room)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}
