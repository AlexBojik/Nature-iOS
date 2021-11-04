
import Foundation

protocol IFileManager {
    func write(data: Data, to file: String)
    func fileExists(_ file: String) -> Bool
    func read(_ file: String) -> Data?
}

class CoreFileManager: IFileManager {
    func write(data: Data, to file: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            try? data.write(to: fileURL)
        }
    }
    
    func fileExists(_ file: String) -> Bool {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        let fileURL = dir.appendingPathComponent(file)
        
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func read(_ file: String) -> Data? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = dir.appendingPathComponent(file)
    
        return try? Data(contentsOf: fileURL)
    }
}
