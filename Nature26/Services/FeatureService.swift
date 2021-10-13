
import CoreLocation
import Mapbox

protocol IFeatureService {
    var networkService: INetworkService {get set}
    var userService: IUserService {get set}

    var features: [Feature] {get set}
    var flyTo: Feature? {get set}
    var loading: Bool {get set}
    
    func search(_ text: String, _ sendObjectChange: @escaping () -> Void) -> Void
    func loadSelectedFeatures(_ identifiers: [Int], _ sendObjectChange: @escaping () -> Void) -> Void
    func flyToFeature(_ flyToCenter: (CLLocationCoordinate2D) -> Void, _ flyToBounds: (MGLCoordinateBounds) -> Void)
}

class FeatureService: IFeatureService {
    private let filterUrl = Config.baseUrl + "filter"
    var flyTo: Feature?
    
    var networkService: INetworkService
    var userService: IUserService
    
    var features: [Feature] = [] {
        didSet {
            if !features.isEmpty {
                dictionary = [:]
                features.forEach { dictionary[$0.id] = $0 }
            }
        }
    }
    func flyToFeature(_ flyToCenter: (CLLocationCoordinate2D) -> Void, _ flyToBounds: (MGLCoordinateBounds) -> Void) {
        if let flyTo = self.flyTo {
            if let center = flyTo.geoJson?.center {
                flyToCenter(center)
            }
            if let bounds = flyTo.geoJson?.bounds {
                flyToBounds(bounds)
            }
            self.flyTo = nil
        }
    }
    
    var dictionary: [Int: Feature] = [:]
    
    var loading: Bool = false
    
    init(_ networkService: INetworkService, _ userService: IUserService) {
        self.networkService = networkService
        self.userService = userService
    }
    
    func getFeature(_ id: Int) -> Feature? {
        return dictionary[id]
    }
    
    func loadSelectedFeatures(_ identifiers: [Int], _ sendObjectChange: @escaping () -> Void) {
        guard !identifiers.isEmpty else { return }
        
        let stringIdentifiers = identifiers.map( { String($0) } ).joined(separator: ",")
        let filter = Filter(identifiers: stringIdentifiers)
        
        getFeatures(filter, sendObjectChange)
    }
    
    func search(_ text: String, _ sendObjectChange: @escaping () -> Void) {
        guard !text.isEmpty else { return }
        let filter = Filter(text: text)
        
        getFeatures(filter, sendObjectChange)
    }
    
    private func getFeatures(_ filter: Filter, _ sendObjectChange: @escaping () -> Void) {
        loading = true
        features = []
        sendObjectChange()
        
        let token = userService.token
        
        networkService.getFeatures(with: filter, url: filterUrl, token: token) {features in
            DispatchQueue.main.sync {
                self.updateFeatures(features)
                sendObjectChange()
            }
        }
    }
    
    func updateFeatures(_ features: [Feature]?) {
        self.loading = false
        guard let features = features else { return }
        self.features = features
    }
}
