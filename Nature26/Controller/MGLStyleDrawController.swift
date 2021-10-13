
import Mapbox

extension MGLStyle {
    func addRasterLayer(_ base: BaseLayer) {
        let source = MGLRasterTileSource(base)
        addSource(source)
        insertLayer(MGLRasterStyleLayer(identifier: "base", source: source), at: 1)
    }
    
    func addFillLayer(_ layer: Layer, source: MGLShapeSource) {
        if self.layer(withIdentifier: layer.identifier) == nil, let color = layer.fillColorUI {
            let fillLayer = MGLFillStyleLayer(identifier: layer.identifier, source: source)
            
            fillLayer.fillColor = NSExpression(forConstantValue: color)
            fillLayer.fillOpacity = NSExpression(forConstantValue: 0.7)
            
            // only for Polygons
            fillLayer.predicate = NSPredicate(format: "$geometryType = 'Polygon'")
            
            insertLayer(fillLayer, at: 2)
        }
    }
    
    func addLineLayer(_ layer: Layer, source: MGLShapeSource) {
        if self.layer(withIdentifier: layer.lineIdentifier) == nil,
           let color = layer.lineColorUI,
           let width = layer.lineWidth {
            
            let lineLayer = MGLLineStyleLayer(identifier: layer.lineIdentifier, source: source)
            lineLayer.lineColor = NSExpression(forConstantValue: color)
            lineLayer.lineWidth = NSExpression(forConstantValue: width)
            
            // only for Polygons
            lineLayer.predicate = NSPredicate(format: "$geometryType = 'Polygon'")

            addLayer(lineLayer)
        }
    }
    
    func addClusterLayer(_ layer: Layer, source: MGLShapeSource) {
        if self.layer(withIdentifier: layer.clusterIdentifier) == nil,
           let symbol = layer.symbol {
            
            let clusterLayer = MGLSymbolStyleLayer(identifier: layer.clusterIdentifier, source: source)
            
            clusterLayer.sourceLayerIdentifier = layer.clusterIdentifier
            clusterLayer.iconImageName = NSExpression(forConstantValue: symbol)
            clusterLayer.iconScale = NSExpression(forConstantValue: 0.5)
        
            addLayer(clusterLayer)
        }
    }
    
    func addSymbolLayer(_ layer: Layer, source: MGLShapeSource) {
        if self.layer(withIdentifier: layer.pointIdentifier) == nil,
           let symbol = layer.symbol {
            
            let symbolLayer = MGLSymbolStyleLayer(identifier: layer.pointIdentifier, source: source)
            
            symbolLayer.sourceLayerIdentifier = layer.identifier
            symbolLayer.iconImageName = NSExpression(forConstantValue: symbol)
            symbolLayer.iconScale = NSExpression(forConstantValue: 0.5)
            
            // only for Points
            symbolLayer.predicate = NSPredicate(format: "$geometryType = 'Point'")
            
            addLayer(symbolLayer)
        }
    }
    
    func addPointLayer(_ layer: Layer, source: MGLShapeSource) {
        if self.layer(withIdentifier: layer.pointIdentifier) == nil,
           let color = layer.fillColorUI,
           layer.symbol == nil {
            
            let pointStyle = MGLCircleStyleLayer(identifier: layer.pointIdentifier, source: source)
            
            pointStyle.sourceLayerIdentifier = layer.identifier
            pointStyle.circleColor = NSExpression(forConstantValue: color)
            pointStyle.circleRadius = NSExpression(forConstantValue: 6)
            pointStyle.circleStrokeColor = NSExpression(forConstantValue: UIColor.white)
            pointStyle.circleStrokeWidth = NSExpression(forConstantValue: 1)
            
            // only for Points
            pointStyle.predicate = NSPredicate(format: "$geometryType = 'Point'")
            
            addLayer(pointStyle)
        }
    }
    
    func setLayerFillOpacity(_ id: String, _ selected: [Int] = []) {
        if let styleLayer = self.layer(withIdentifier: id) as? MGLFillStyleLayer {
            styleLayer.fillOpacity = NSExpression(format: "TERNARY($featureIdentifier IN %@, 1.0, 0.7)", selected)
        }
    }
    
    func setLayerCircleRadius(_ id: String, _ selected: [Int] = []) {
        if let styleLayer = self.layer(withIdentifier: id) as? MGLCircleStyleLayer {
            styleLayer.circleRadius = NSExpression(format: "TERNARY($featureIdentifier IN %@, 8, 6)", selected)
        }
    }
}
