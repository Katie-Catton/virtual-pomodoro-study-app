//
//  Setting.swift
//  study-app
//
//  Created by Katie Catton on 12/8/20.
//

import Foundation

enum settingType {
    case inputTime
    case inputNumSessions
    case toggle
}

class Setting {
    var title: String
    var type: settingType
    
    init(title: String, type: settingType) {
        self.title = title
        self.type = type
    }
}
