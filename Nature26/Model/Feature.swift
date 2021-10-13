import SwiftUI

struct Feature: Decodable, Hashable {
    static func == (lhs: Feature, rhs: Feature) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var layerId: Int
    var name: String
    var geoJson: FlyProperty?
    var description: String
}

class FeatureParser: IParser {
    typealias Model = Feature
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}

class FeatureListParser: IParser {
    typealias Model = [Feature]
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}

class FeatureListApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String, token: String?) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.setValue(token, forHTTPHeaderField: "Token")
        }
    }
}
