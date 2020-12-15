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
    
    // all of the endpoints we need to implement
    // endpoints - /rooms/
    // GET, POST
    // query parameter String, /?code=string/
    // POST, DELETE
    // /signin/
    // POST
    // /join/
    // POST
    
    // /rooms/
    // GET

    static func getRooms(completion: @escaping ([Room]) -> Void) {
        let endpoint = "\(host)/rooms/"
        AF.request(endpoint, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let roomsData = try? jsonDecoder.decode(roomResponse<Room>.self, from: data as! Data) {
                    let rooms = roomsData.data
                    completion([rooms])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //POST
    static func getRoom() {
        
    }
    
    
    // /signin/
    // POST
    func getSession(userToken: String, completion: @escaping (signInReponse) -> Void) {
            let parameters: [String: Any] = [
                "user_token" : userToken
            ]
            let endpoint = "https://virtual-pomodoro.herokuapp.com/signin/"
            AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let session = try? jsonDecoder.decode(signInReponse.self, from: data) {
                        let newSession = session
                        completion(newSession)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
}
