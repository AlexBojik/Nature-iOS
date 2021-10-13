
import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
 
struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
    let uploadData: Data?
}

protocol INetworkManager {
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, Error>) -> Void)
}

enum NetworkError: Error {
    case badUrl
}

enum ParsingError: Error {
    case error
}

class NetworkManager: INetworkManager {
    let session = URLSession.shared

    
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) where Parser: IParser {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(NetworkError.badUrl))
            return
        }
        
        let requestHandler = {(data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data, let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                completionHandler(.failure(ParsingError.error))
                return
            }
            completionHandler(.success(parsedModel))
        }
        
        if let uploadData = config.uploadData {
            let task = session.uploadTask(with: urlRequest, from: uploadData, completionHandler: requestHandler)
            task.resume()
        } else {
            let task = session.dataTask(with: urlRequest, completionHandler: requestHandler)
            task.resume()
        }
    }
}
