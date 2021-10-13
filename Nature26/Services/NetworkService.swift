
import SwiftUI
import CoreLocation
import Mapbox

protocol INetworkService {
    func getBaseLayers(_: String, _: @escaping ([BaseLayer]?) -> Void)
    func getLayer(_: String, _: Layer, _: @escaping (MGLShape?, Layer) -> Void)
    func getUser(_: String, _: @escaping (User?) -> Void)
    func getFeatures(with filter: Filter, url: String, token: String, complition: @escaping ([Feature]?) -> Void)
    func getLayers(_ : String, _ : String?, _ : @escaping ([Layer]?) -> ())
    func getNews(_ : String, _ : @escaping (String?) -> ())
    func sendUserMessage(_ : String, _ : UserMessage, _ : @escaping (Int?) -> ())
    func checkLocation(_ : String, _ : Check, _ : @escaping ([String]?) -> Void)
    }

struct RequestsFactory {
    struct NatureRequest {
        static func baseLayerListConfig(_ url: String) -> RequestConfig<BaseLayerListParser> {
            return RequestConfig(request: BaseLayerListApiRequest(urlString: url),
                                 parser: BaseLayerListParser(), uploadData: nil)
        }
        
        static func layerListConfig(_ url: String, _ token: String?) -> RequestConfig<LayerListParser> {
            return RequestConfig(request: LayerListApiRequest(urlString: url, token: token),
                                 parser: LayerListParser(), uploadData: nil)
        }
        
        static func layerConfig(_ url: String, _ layer: Layer) -> RequestConfig<LayerParser> {
            return RequestConfig(request: LayerApiRequest(urlString: url, layer: layer),
                                 parser: LayerParser(), uploadData: nil)
        }
        
        static func userConfig(_ url: String) -> RequestConfig<UserParser> {
            return RequestConfig(request: UserApiRequest(urlString: url),
                                 parser: UserParser(), uploadData: nil)
        }
        
        static func filterConfig(_ url: String, _ token: String, _ data: Data?) -> RequestConfig<FeatureListParser> {
            return RequestConfig(request: FilterApiRequest(urlString: url, token: token),
                                 parser: FeatureListParser(), uploadData: data)
        }
        
        static func newsConfig(_ url: String) -> RequestConfig<NewsParser> {
            return RequestConfig(request: NewsApiRequest(urlString: url),
                                 parser: NewsParser(), uploadData: nil)
        }
        
        static func checkConfig(_ url: String, _ data: Data?) -> RequestConfig<CheckParser> {
            return RequestConfig(request: CheckApiRequest(url),
                                 parser: CheckParser(), uploadData: data)
        }
        
        static func userMessageConfig(_ url: String, _ data: Data?) -> RequestConfig<UserMessageParser> {
            return RequestConfig(request: UserMessageApiRequest(url),
                                 parser: UserMessageParser(), uploadData: data)
        }
    }
}

class NetworkService: INetworkService {
    var networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    private func send<T>(config: RequestConfig<T>, complitionHandler: @escaping (T.Model?) -> Void) {
        networkManager.send(config: config) { (result: Result<T.Model, Error>) in
            switch result {
            case .success(let object):
                complitionHandler(object)
            case .failure(let error):
                print(error.localizedDescription)
                complitionHandler(nil)
            }
        }
    }
    
    func getUser(_ url: String, _ complition: @escaping (User?) -> ()) {
        let config = RequestsFactory.NatureRequest.userConfig(url)
        send(config: config, complitionHandler: complition)
    }
    
    func getBaseLayers(_ url: String, _ complition: @escaping ([BaseLayer]?) -> Void) {
        let config = RequestsFactory.NatureRequest.baseLayerListConfig(url)
        send(config: config, complitionHandler: complition)
    }
    
    func getLayers(_ url: String, _ token: String?, _ complition: @escaping ([Layer]?) -> ()) {
        let config = RequestsFactory.NatureRequest.layerListConfig(url, token)
        send(config: config, complitionHandler: complition)
    }
    
    func getFeatures(with filter: Filter, url: String, token: String, complition: @escaping ([Feature]?) -> ()) {
        guard let uploadData = try? JSONEncoder().encode(filter) else { return }
        
        let config = RequestsFactory.NatureRequest.filterConfig(url, token, uploadData)
        send(config: config, complitionHandler: complition)
    }
    
    func checkLocation(_ url: String, _ check: Check, _ complition: @escaping ([String]?) -> Void) {
        guard let uploadData = try? JSONEncoder().encode(check) else { return }
        
        let config = RequestsFactory.NatureRequest.checkConfig(url, uploadData)
        send(config: config, complitionHandler: complition)
    }
    
    func getLayer(_ url: String, _ layer: Layer, _ complition: @escaping (MGLShape?, Layer) -> Void) {
        let config = RequestsFactory.NatureRequest.layerConfig(url, layer)
        send(config: config) { shape in
            complition(shape, layer)
        }
    }
    
    func getNews(_ url: String, _ complition: @escaping (String?) -> ()) {
        let config = RequestsFactory.NatureRequest.newsConfig(url)
        send(config: config, complitionHandler: complition)
    }
    
    func sendUserMessage(_ url: String, _ userMessage: UserMessage, _ complition: @escaping (Int?) -> ()) {
        guard let uploadData = try? JSONEncoder().encode(userMessage) else { return }
        
        let config = RequestsFactory.NatureRequest.userMessageConfig(url, uploadData)
        send(config: config, complitionHandler: complition)
    }
}
