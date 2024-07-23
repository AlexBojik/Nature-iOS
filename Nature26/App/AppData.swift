
import SwiftUI
import Mapbox

class AppData: ObservableObject {
    var networkService: INetworkService
    var userService: IUserService
    var fileService: IFileService

    @Published var showLayerListDescription: Bool = false
    @Published var flyToLocationIsActive: Bool = false
    @Published var flyToLocationCoord: CLLocationCoordinate2D? = nil
    @Published var baseLayerService: IBaseLayerService
    @Published var layerService: ILayerService
    @Published var featureService: IFeatureService
    @Published var newsService: INewsService
    @Published var notificationService: INotificationService
    
    lazy var locationService = LocationService(networkService, notificationService) {
        DispatchQueue.main.async {
            self.showLayerListDescription = true
            self.objectWillChange.send()
        }
    }
    
    init() {
        networkService = NetworkService(networkManager: NetworkManager())
        userService = UserService(networkService)
        fileService = FileService(CoreFileManager())
        
        baseLayerService = BaseLayerService(networkService)
        layerService = LayerService(networkService, userService, fileService)
        featureService = FeatureService(networkService, userService)
        notificationService = NotificationService()
        newsService = NewsService(networkService)
        
        baseLayerService.updateLayers()
        layerService.updateLayers()

        notificationService.requestPermission()
        locationService.requestPermission()
    }
}
