//
//  ImageSave.swift
//  OrganizedHome
//
//  Created by Yingjing Lin on 2/2/21.
//

import Foundation
import SwiftUI

struct ImageStorage {
    
    static func save(image: UIImage?) -> String? {
        if let data = image?.jpegData(compressionQuality: 0.9) {
            let fileName = UUID().uuidString
            let fullFileName = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: fullFileName)
            return fileName
        }
        return nil
    }
    
    static func delete(imgName: String) {
        let fullFileName = getDocumentsDirectory().appendingPathComponent(imgName)
        do {
            try FileManager.default.removeItem(at: fullFileName)
        } catch {print("Failed to delete image.")}
    }
    
    static func load(imageName: String) -> UIImage? {
        let fullFileName = getDocumentsDirectory().appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: fullFileName)
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }
    
    private static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}

extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
