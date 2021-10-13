
import Foundation

protocol INewsService {
    var networkService: INetworkService { get }
    var news: String { get set }
    var loading: Bool { get set }
    func updateNews(_: @escaping () -> Void) -> Void
}

class NewsService: INewsService {
    var networkService: INetworkService
    var loading = false {
        didSet {
            if loading {
                news = ""
            }
        }
    }
    
    var news: String = ""
    
    init(_ networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func updateNews(_ objectWillChange: @escaping () -> Void) {
        loading = true
        objectWillChange()

        networkService.getNews(Config.baseUrl + "news") { news in
            DispatchQueue.main.async {
                self.news = news ?? ""
                self.loading = false
                objectWillChange()
            }
        }
    }
}
