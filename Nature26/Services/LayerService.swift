
import Foundation

protocol ILayerService {
    var networkService: INetworkService { get }
    var userService: IUserService { get }
    
    var layers: [Layer] { get set }
    var layersChanged: Bool { get set }
    var layersDescripton: String { get }
    
    func getLayer(_: Int) -> Layer?
    func updateLayers() -> Void
    func updateLayerList(_ style: IMGLStyleWorkWithLayer)
}

class LayerService: ILayerService {
    private let url = Config.baseUrl + "layers"
    private let urlCluster = Config.baseUrl + "cluster"
    
    var networkService: INetworkService
    var userService: IUserService
    
    var layersDescripton: String {
        var res = ""
        layers.forEach { layer in
            layer.layers?.forEach({ child in
                if child.warning ?? false {
                    res += "<h3>\(child.commonName ?? "")</h3>\(child.commonDescription ?? "")<br>"
                }
            })
        }
        return res
    }
    
    init(_ networkService: INetworkService, _ userService: IUserService) {
        self.networkService = networkService
        self.userService = userService
    }
    
    private var dictionary: [Int: Layer] = [:]
    
    var layers: [Layer] = [] {
        didSet {
            dictionary = [:]
            layers.forEach { layer in
                layer.layers?.forEach({ dictionary[$0.id] = $0 })
            }
        }
    }
    var layersChanged = false
    
    func updateLayerList(_ style: IMGLStyleWorkWithLayer) {
        if layersChanged {
            layersChanged = false
            layers.forEach { layer in
                layer.layers?.forEach { child in
                    if child.visible {
                        if !child.loading, style.sourceIsNotLoad(child.identifier) {
                            child.loading = true
                            networkService.getLayer(url, child, style.addLayer)
                        }
                        if !child.clusterLoading, style.sourceIsNotLoad(child.clusterIdentifier), child.cluster ?? false {
                            child.clusterLoading = true
                            networkService.getLayer(urlCluster, child, style.addCluster)
                        }
                    }
                    
                    style.setLayerVisible(child.identifier, child.visible)
                    style.setLayerVisible(child.pointIdentifier, child.visible)
                    style.setLayerVisible(child.clusterIdentifier, child.visible)
                    style.setLayerVisible(child.lineIdentifier, child.visible)
                }
            }
        }
    }
    
    func updateLayers() {
        networkService.getLayers(url, userService.token) { layers in
            DispatchQueue.main.async {
                guard let layers = layers else { return }
                self.layers = layers
            }
        }
    }
    
    func getLayer(_ id: Int) -> Layer? {
        return dictionary[id]
    }
}
