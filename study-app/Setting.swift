//
//  Setting.swift
//  study-app
//
//  Created by Katie Catton on 12/8/20.
//

import Foundation

enum settingType {
    case inputNum
    case toggle
}

class Setting {
    var title: String
    var placeholderText: String
    var type: settingType
    
    init(title: String, text: String, type: settingType) {
        self.title = title
        placeholderText = text
        self.type = type
    }
}
