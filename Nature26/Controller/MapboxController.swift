
import Mapbox

extension MapboxView {
    func updateLocation() {
        if appData.flyToLocationIsActive {
            appData.flyToLocationIsActive = false
            
            guard let center = mapView.userLocation?.coordinate else { return }
            
            fly(to: center)
            mapView.userTrackingMode = .followWithHeading
        }
    }
    
    func fly(to center: CLLocationCoordinate2D) {
        mapView.fly(to: MGLMapCamera(lookingAtCenter: center, altitude: 4500, pitch: 15, heading: 0))
    }

    func fly(to bounds: MGLCoordinateBounds) {
        mapView.fly(to: mapView.cameraThatFitsCoordinateBounds(bounds))
    }
}
