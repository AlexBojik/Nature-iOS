
import UIKit

struct UserMessage: Encodable {
    var images: [UIImage]
    var text: String
    var lat: Double
    var lon: Double
    var token: String
    
    init(images: [UIImage], text: String, token: String) {
        self.images = images
        self.text = text
        self.lat = 0.0
        self.lon = 0.0
        self.token = token
    }
}

class UserMessageApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(_ urlString: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = "POST"
            urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

class UserMessageParser: IParser {
    typealias Model = Int
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}
