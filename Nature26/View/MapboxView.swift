
import SwiftUI
import Mapbox

struct MapboxView: UIViewRepresentable {
    @EnvironmentObject var appData: AppData
    
    var mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: Config.style)
    
    func makeUIView(context: UIViewRepresentableContext<MapboxView>) -> MGLMapView {
        mapView.delegate = context.coordinator
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        
        mapView.showsUserHeadingIndicator = true
        mapView.showsUserLocation = true
        
        mapView.zoomLevel = Config.zoomLevel
        mapView.centerCoordinate = Config.centerCoordinate
        mapView.maximumZoomLevel = Config.maximumZoomLevel
        
        return mapView
    }
    
    func makeCoordinator() -> MapboxView.Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapboxView>) {
        guard let style = mapView.style else { return }
        
        appData.baseLayerService.updateBaseLayerList(style.changeBase)
        appData.layerService.updateLayerList(style)
        appData.featureService.flyToFeature(fly, fly)
        
        updateLocation()
    }
}
