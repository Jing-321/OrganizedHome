//
//  Tag.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/8/21.
//

import Foundation
import SwiftUI

class Tag: Identifiable, Codable {
    var name: String
    var color: TagColor
    var displayColor: Color {
        switch color {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .white:
            return .white
        default:
            return .white
        }
    }
    var id: String {
        get {
            return name
        }
    }
    
    init(name: String, color: TagColor) {
        self.name = name
        self.color = color
    }
}

enum TagColor: String, Codable {
    case red
    case green
    case blue
    case yellow
    case white
}
