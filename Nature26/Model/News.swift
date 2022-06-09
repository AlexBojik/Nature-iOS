
import SwiftUI

struct News: Decodable, Hashable {
    var id: Int;
    var created: String;
    var start: Date;
    var end: String;
    var description: String;
}

class NewsApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
        }
    }
}

class NewsParser: IParser {
    typealias Model = String
    
    func parse(data: Data) -> Model? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let newsArray = try? decoder.decode([News].self, from: data)

        guard let newsArray = newsArray?.sorted(by: { $0.start > $1.start}) else { return nil }
    
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        
        return newsArray.reduce("", { $0 + "<h3>\(dateFormatterPrint.string(from: $1.start))</h3>\($1.description)" })
    }
}
