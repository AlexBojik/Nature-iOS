
import Mapbox

extension MapboxView {
    func updateLocation() {
        if appData.flyToLocationCoord != nil {
            guard let center = appData.flyToLocationCoord else { return }

            makeMarker(at: center)
            fly(to: center)
            mapView.userTrackingMode = .none

            appData.flyToLocationCoord = nil
        }

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

    func makeMarker(at coordinate: CLLocationCoordinate2D) {
        let point = MGLPointAnnotation()
        point.coordinate = coordinate
        if let existsAnnotations = mapView.annotations {
            mapView.removeAnnotations(existsAnnotations)
        }
        mapView.addAnnotation(point)
    }
}
