/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation

struct DataStorage {
    
    static let fileName = "inventory.json";
    
    static let templateUrl = Bundle.main.url(forResource: fileName, withExtension: nil)

    static var storageObject: StorageObject = load()
    
    static private func load() -> StorageObject {
        guard let file = getFullUrl(fileName: fileName)
            else {
                fatalError("Couldn't find \(fileName) in main bundle.")
        }

        var storageObject: StorageObject
        do {
            storageObject = try parseFile(url: file)
        } catch {
            do {
                print("Couldn't load \(fileName); trying to load the default JSON:\n\(error)")
                storageObject = try parseFile(url: templateUrl!)
            } catch {
                fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
            }
        }
        
        addParents(area: storageObject.inventory)
        return storageObject
    }
    
    static private func parseFile(url: URL) throws -> StorageObject {
        let data = try Data(contentsOf: url)
        print(String(decoding: data, as: UTF8.self))
        let decoder = JSONDecoder()
        return try decoder.decode(StorageObject.self, from: data)
    }

    static func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(storageObject)
            // print(String(decoding: jsonData, as: UTF8.self))
            try jsonData.write(to: getFullUrl(fileName: fileName)!)
        } catch {
            fatalError("Couldn't save \(Area.self) to \(fileName):\n\(error)")
        }
    }
    
    private static func getFullUrl(fileName: String) -> URL? {
        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            return documentDirectory.appendingPathComponent(fileName)
        } catch {
            return nil
        }
    }
    
    private static func addParents(area: Area) {
        area.areas.forEach({ $0.parent = area })
        area.items.forEach({ $0.parent = area })
        area.areas.forEach(addParents)
    }
}
