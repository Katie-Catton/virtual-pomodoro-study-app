//
//  NetworkManager.swift
//  study-app
//
//  Created by Katie Catton on 12/6/20.
//

import Foundation
import Alamofire

enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

class NetworkManager {
    
    static let endpoint = "/rooms/"
    
    // all of the enpoints we need to implement
    // endpoints - /rooms/
    // GET, POST
    // query parameter String, /?code=string/
    // POST, DELETE
    // /signin/
    // POST
    // /join/
    // POST
    
//    static func getRooms() {
//        AF.request(endpoint, method: HTTPMethod.get().validate().responseJSON { response in
//            
//        }
//    }
}
