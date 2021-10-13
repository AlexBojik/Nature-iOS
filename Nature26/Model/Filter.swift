import Foundation

enum FilterType: Int, Encodable {
    case byText = 1
    case byIdentifiers = 2
}

struct Filter: Encodable {
    var type: FilterType
    var str: String
    
    init(identifiers: String) {
        self.type = .byIdentifiers
        self.str = identifiers
    }
    
    init(text: String) {
        self.type = .byText
        self.str = text
    }
}

class FilterApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String, token: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = "POST"
            urlRequest?.setValue(token, forHTTPHeaderField: "Token")
            urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
