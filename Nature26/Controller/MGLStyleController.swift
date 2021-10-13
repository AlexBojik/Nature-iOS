
import Mapbox
import SwiftUI

protocol IMGLStyleWorkWithLayer {
    func setLayerVisible(_: String, _: Bool)
    func addLayer(_: MGLShape?, _: Layer)
    func addCluster(_: MGLShape?, _: Layer)
    func sourceIsNotLoad(_: String) -> Bool
}

extension MGLStyle {
    func changeBase(_ base: BaseLayer) {
        removeLayer("base")
        addRasterLayer(base)
    }
    
    func removeLayer(_ id: String) {
        if let layer = layer(withIdentifier: id) {
            removeLayer(layer)
        }
        if let source = source(withIdentifier: id) {
            removeSource(source)
        }
    }
}

extension MGLStyle: IMGLStyleWorkWithLayer {
    func setLayerVisible(_ id: String, _ visible: Bool) {
        layer(withIdentifier: id)?.isVisible = visible
    }
    
    func addLayer(_ shape: MGLShape?, _ layer: Layer) {
        DispatchQueue.main.async {
            layer.loading = false
            guard let shape = shape else { return }

            let source = MGLShapeSource(identifier: layer.identifier, shape: shape)
            self.addSource(source)
        
            self.addFillLayer(layer, source: source)
            self.addLineLayer(layer, source: source)
            self.addSymbolLayer(layer, source: source)
            self.addPointLayer(layer, source: source)
        }
    }
    
    func addCluster(_ shape: MGLShape?, _ layer: Layer) {
        DispatchQueue.main.async {
            layer.clusterLoading = false
            guard let shape = shape else { return }

            let source = MGLShapeSource(identifier: layer.clusterIdentifier, shape: shape)
            self.addSource(source)
        
            self.addClusterLayer(layer, source: source)
        }
    }
    
    func sourceIsNotLoad(_ id: String) -> Bool {
        return source(withIdentifier: id) == nil
    }
}
