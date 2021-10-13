
import Mapbox

extension MapboxView {
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapboxView
        
        var selectedIdentifiers: [Int] = []
        var selectedLayerIdentifiers: Set<Int> = Set()
        
        init(_ control: MapboxView) {
            self.control = control
        }

        @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
            selectedIdentifiers = []
            setSelectedStyle()
            selectedLayerIdentifiers = []
            
            let spot = sender.location(in: self.control.mapView)
            let features = control.mapView.visibleFeatures(at: spot)
            
            features.forEach {
                if let id = $0.identifier as? Int {
                    self.selectedIdentifiers.append(id)
                    if let layerId = $0.attribute(forKey: "layerId") as? Int {
                        self.selectedLayerIdentifiers.insert(layerId)
                    }
                }
            }
            
            setSelectedStyle()
            
            self.control.appData.featureService.loadSelectedFeatures(selectedIdentifiers, self.control.appData.objectWillChange.send)
        }
        
        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
            style.addRasterLayer(Config.defaultBase)

            let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
            
            mapView.gestureRecognizers?.forEach {
                if $0 is UITapGestureRecognizer {
                    singleTap.require(toFail: $0)
                }
            }
            
            mapView.addGestureRecognizer(singleTap)
            
            control.appData.flyToLocationIsActive = true
            
            Config.images.forEach {
                if let image = UIImage(named: $0) {
                    style.setImage(image, forName: $0)
                }
            }
        }
        
        func setSelectedStyle() {
            selectedLayerIdentifiers.forEach {
                control.mapView.style?.setLayerFillOpacity("layer\($0)", selectedIdentifiers)
                control.mapView.style?.setLayerCircleRadius("layer\($0)-point", selectedIdentifiers)
            }
        }
    }
}
