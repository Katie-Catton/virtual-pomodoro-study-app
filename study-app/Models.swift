//
//  Models.swift
//  study-app
//
//  Created by Katie Catton on 12/12/20.
//

import Foundation

struct User: Codable {
    let username: String
}

struct Room: Codable {
    let opentokId: String
    let code: String
    let numSessions: Int
    let workLength: Int
    let breakLength: Int
    let users: [User]?
    let paused: Bool
}

struct RoomsDataResponse: Codable {
    var roooms: [Room]
}

struct Response<T: Codable>: Codable {
    let data: T
    let success: Bool
}




