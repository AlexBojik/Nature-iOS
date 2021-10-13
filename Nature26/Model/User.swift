import Foundation

struct User: Decodable {
    var token: String
    var name: String
}

class UserApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
        }
    }
}

class UserParser: IParser {
    typealias Model = User
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}
