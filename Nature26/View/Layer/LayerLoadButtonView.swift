
import SwiftUI

struct LayerLoadButtonView: View {
    @EnvironmentObject var appData: AppData
    
    private let url = Config.baseUrl + "layers"
    private let urlCluster = Config.baseUrl + "cluster"
    
    var layer: Layer
    
    var body: some View {
        if !layer.isGroup {
            if !appData.fileService.dataLoaded(of: layer) && !layer.loading {
                Button(.load) {
                    appData.objectWillChange.send()
                    layer.loading = true
                    
                    appData.networkService.getLayer(url, layer) { shape, layer in
                        guard let shape = shape else { return }
                        
                        appData.fileService.write(shape: shape, with: layer)

                        DispatchQueue.main.async {
                            appData.objectWillChange.send()
                            layer.loading = false
                        }
                    }
                }
            }
            
            if layer.loading {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .blue))
            }
        }
    }
}
