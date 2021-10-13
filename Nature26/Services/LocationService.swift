
import CoreLocation
import UserNotifications

class LocationService: NSObject, CLLocationManagerDelegate {
    private let url = Config.baseUrl + "check"
    
    let locationManager = CLLocationManager()
    
    var networkService: INetworkService
    var notificationService: INotificationService
    
    var showLayerListDescription: () -> ()
    
    var lastLocation: CLLocation?
    
    init(_ networkService: INetworkService, _ notificationService: INotificationService, _ showLayerListDescription: @escaping () -> ()) {
        self.networkService = networkService
        self.notificationService = notificationService
        self.showLayerListDescription = showLayerListDescription
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false

        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        scheduleNotification(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    func scheduleNotification(locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
            networkService.checkLocation(url, Check(location.coordinate)) { layerNameList in
                if let layerNameList = layerNameList, layerNameList.count > 0 {
                    self.showLayerListDescription()
                    self.notificationService.showLayerNotification(layerNameList)
                }
            }
        }
    }
}
