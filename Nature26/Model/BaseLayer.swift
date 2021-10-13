import Foundation

struct BaseLayer: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var url: String
    var description: String
    var minZoom: Double
    var maxZoom: Double
    
    static func == (lhs: BaseLayer, rhs: BaseLayer) -> Bool {
        return lhs.name == rhs.name
    }
}

class BaseLayerListApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
        }
    }
}

class BaseLayerListParser: IParser {
    typealias Model = [BaseLayer]
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}
