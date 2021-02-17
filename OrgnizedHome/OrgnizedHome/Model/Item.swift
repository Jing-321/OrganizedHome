//
//  Item.swift
//  OrgnizedHome
//
//  Created by Yingjing Lin on 1/30/21.
//

import Foundation
import SwiftUI

class Item: BaseEntity {

    @Published var note: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case note
        case imgName
        case isFavorite
    }
    
    init(id: String?, name: String, note: String, imgName: String?, parent: Area?, isFavorite: Bool) {
        self.note = note
        super.init(id: id, name: name, imgName: imgName, parent: parent, isFavorite: isFavorite)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsedId = try container.decode(String.self, forKey: .id)
        let parsedName = try container.decode(String.self, forKey: .name)
        let parsedImgName = try container.decodeIfPresent(String.self, forKey: .imgName)
        let parsedIsFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        super.init(id: parsedId, name: parsedName, imgName: parsedImgName, parent: nil, isFavorite: parsedIsFavorite)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(note, forKey: .note)
        try container.encodeIfPresent(imgName, forKey: .imgName)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
    
    func move(newLocation: Area, parent: Area) {
        newLocation.items.append(self)
        parent.items.removeAll(where: {$0.id == self.id})
        self.parent = newLocation
        DataStorage.save()
        parent.objectWillChange.send()
        newLocation.objectWillChange.send()
    }
    
    func toggleFavorite() {
        isFavorite = !isFavorite
        self.objectWillChange.send()
        location.forEach({ $0.objectWillChange.send() })
        DataStorage.save()
    }
}
