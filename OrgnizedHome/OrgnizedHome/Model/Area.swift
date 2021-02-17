//
//  Area.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 1/30/21.
//

import Foundation
import Combine
import SwiftUI

class Area: BaseEntity {
    
    @Published var areas: [Area]
    var children: [Area]? {
        get {
            return areas.isEmpty ? nil : Optional(areas)
        }
    }
    @Published var items: [Item]
    var descendantAreas: [Area] {
        get {
            var result = self.areas
            result.append(contentsOf: self.areas.flatMap( { $0.descendantAreas }))
            return result
        }
    }
    var descendantItems: [Item] {
        get {
            var result = self.items
            result.append(contentsOf: self.areas.flatMap( { $0.descendantItems }))
            return result
        }
    }
    var allAreas: [Area] {
        get {
            var areas = [DataStorage.storageObject.inventory]
            areas.append(contentsOf: DataStorage.storageObject.inventory.areas.flatMap({$0.descendantAreas}))
            return areas
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imgName
        case areas
        case items
        case isFavorite
    }
    
    override init(id: String?, name: String, imgName: String?, parent: Area?, isFavorite: Bool) {
        self.areas = []
        self.items = []
        super.init(id: id, name: name, imgName: imgName, parent: parent, isFavorite: isFavorite)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsedId = try container.decode(String.self, forKey: .id)
        let parsedName = try container.decode(String.self, forKey: .name)
        let parsedImgName = try container.decodeIfPresent(String.self, forKey: .imgName)
        let parsedIsFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        areas = try container.decode([Area].self, forKey: .areas)
        items = try container.decode([Item].self, forKey: .items)
        super.init(id: parsedId, name: parsedName, imgName: parsedImgName, parent: nil, isFavorite: parsedIsFavorite)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(areas, forKey: .areas)
        try container.encode(items, forKey: .items)
        try container.encode(imgName, forKey: .imgName)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
    
    func move(newLocation: Area, parent: Area) {
        newLocation.areas.append(self)
        parent.areas.removeAll(where: { $0.id == self.id})
        self.parent = newLocation
        DataStorage.save()
        parent.objectWillChange.send()
        newLocation.objectWillChange.send()
    }
}
