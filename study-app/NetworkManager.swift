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
    
    private static let host = ""
    
    // all of the enpoints we need to implement
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
    static func getRooms(completion: @escaping ([]) -> Void) {
        let endpoint = "\(host)/rooms/"
        AF.request(endpoint, method: HTTPMethod.get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //POST
    
    static func getRoom() {
        
    }
}
