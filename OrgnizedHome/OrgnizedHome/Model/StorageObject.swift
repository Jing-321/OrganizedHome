//
//  Inventory.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 2/8/21.
//

import Foundation

class StorageObject: Codable {
    
    var inventory: Area
    var tags: [Tag]
    
    init(inventory: Area, tags: [Tag]) {
        self.inventory = inventory
        self.tags = tags
    }
}
