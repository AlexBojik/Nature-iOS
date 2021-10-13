import CoreLocation

struct Check: Encodable {
    var lon: CLLocationDegrees
    var lat: CLLocationDegrees
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.lon = coordinate.longitude
        self.lat = coordinate.latitude
    }
}

class CheckApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(_ urlString: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = "POST"
            urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

class CheckParser: IParser {
    typealias Model = [String]
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}
