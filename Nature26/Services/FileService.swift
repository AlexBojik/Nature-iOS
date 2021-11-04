
import Mapbox


protocol IFileService {
    func write(shape: MGLShape, with layer: Layer)
    func dataLoaded(of layer: Layer) -> Bool
    func getShape(for layer: Layer) -> MGLShape?
}

class FileService: IFileService {
    var fileManager: IFileManager
    
    init(_ fileManager: IFileManager) {
        self.fileManager = fileManager
    }
    
    func write(shape: MGLShape, with layer: Layer) {
        let data = shape.geoJSONData(usingEncoding: String.Encoding.utf8.rawValue)
        fileManager.write(data: data, to: "\(layer.identifier).json")
    }
    
    func dataLoaded(of layer: Layer) -> Bool {
        fileManager.fileExists("\(layer.identifier).json")
    }
    
    func getShape(for layer: Layer) -> MGLShape? {
        let data = fileManager.read("\(layer.identifier).json") ?? Data()
        let shape = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue)
        
        return shape
    }
}
