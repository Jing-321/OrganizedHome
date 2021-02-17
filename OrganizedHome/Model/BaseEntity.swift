//
//  BaseEntity.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/7/21.
//

import Foundation
import SwiftUI

class BaseEntity: Codable, Identifiable, ObservableObject {
    
    var id: String
    @Published var name: String
    var parent: Area? = nil
    var location: [Area] {
        get {
            var path: [Area] = []
            var ancestor: Area? = self.parent
            while ancestor != nil {
                path.insert(ancestor!, at: 0)
                ancestor = ancestor?.parent
            }
            return path
        }
    }
    var locationText: String {
        get {
            location.map({ $0.name }).joined(separator: " > ")
        }
    }
    var imgName: String?
    var img: Image {
        get {
            return imgName.flatMap({ ImageStorage.load(imageName: $0) })
                .map({ Image(uiImage: $0) })
                ?? Image("area_default_img")
        }
    }
    var isFavorite = false
    
    init(id: String?, name: String, imgName: String?, parent: Area?, isFavorite: Bool) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.imgName = imgName
        self.parent = parent
        self.isFavorite = isFavorite
    }
    
    required convenience init(from decoder: Decoder) throws {
        // Do nothing
        self.init(id: nil, name: "", imgName: nil, parent: nil, isFavorite: false)
    }
    
    func encode(to encoder: Encoder) throws {
        fatalError("Can't encode using base class")
    }
    
    func delete() {
        if parent != nil {
            parent!.items.removeAll(where: { $0.id == id })
            parent!.areas.removeAll(where: { $0.id == id })
            if imgName != nil {
                ImageStorage.delete(imgName: imgName!)
            }
            parent!.objectWillChange.send()
            DataStorage.save()
        }
    }
}
