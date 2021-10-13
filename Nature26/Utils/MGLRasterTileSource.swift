import Mapbox

extension MGLRasterTileSource {
    convenience init(_ baseLayer: BaseLayer) {
        self.init(
            identifier: "base",
            tileURLTemplates: [baseLayer.url],
            options: [
                .tileSize: Config.tileSize,
                .minimumZoomLevel: baseLayer.minZoom,
                .maximumZoomLevel: baseLayer.maxZoom
            ])
    }
}
