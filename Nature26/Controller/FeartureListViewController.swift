
import SwiftUI

extension FeatureListView: Dragable {
    func onDragEnded(v: DragGesture.Value) {
        if v.translation.height < 0 {
            if size > UIScreen.height / 2 {
                size = UIScreen.height - 30
            } else {
                size = UIScreen.height / 2
            }
        } else {
            if size < UIScreen.height / 2 {
                appData.featureService.features = []
            }
            size = UIScreen.height / 2
        }
        oldSize = size
    }
    
    func onDragChanged(v: DragGesture.Value) {
        size = oldSize - v.translation.height
    }
}

extension FeatureListView {
    func flyToFeature(layer: Layer, feature: Feature) {
        appData.featureService.flyTo = feature
        if !layer.visible {
            layer.visible = true
            appData.layerService.layersChanged = true
        }
        appData.featureService.features = []
    }
}
