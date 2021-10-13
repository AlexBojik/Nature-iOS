
import Foundation

protocol IBaseLayerService {
    var networkService: INetworkService { get }
    var layers: [BaseLayer] { get set }
    var current: BaseLayer { get set }
    var currentIsChanged: Bool { get set }
    
    func updateLayers() -> Void
    func icon(_: BaseLayer) -> Icons
    func updateBaseLayerList(_ updateAction: (BaseLayer) -> Void)
}

class BaseLayerService: IBaseLayerService {
    var networkService: INetworkService
    var layers: [BaseLayer] = [Config.defaultBase]
    var current: BaseLayer = Config.defaultBase {
        didSet {
            currentIsChanged = current != oldValue
        }
    }
    var currentIsChanged = false
    
    init(_ networkService: INetworkService) {
        self.networkService = networkService
    }
    
    
    func updateLayers() {
        networkService.getBaseLayers(Config.baseUrl + "base_layers") { layers in
            DispatchQueue.main.async {
                guard let layers = layers else { return }
                self.layers = layers
            }
        }
    }
    
    func icon(_ layer: BaseLayer) -> Icons {
        return Icons.radioButtonIcon(layer == current)
    }
    
    func updateBaseLayerList(_ updateAction: (BaseLayer) -> Void) {
        if currentIsChanged {
            currentIsChanged = false
           updateAction(current)
        }
    }
}
