
import SwiftUI

struct BaseLayersListView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            TitleTextView(text: Config.baseLayerListName)
            
            List(appData.baseLayerService.layers) { (layer) in
                HStack {
                    Image(appData.baseLayerService.icon(layer)).foregroundColor(.accentColor)
                    Button(action: { onClickLayer(layer) }, label: { Text(layer.description) })
                }
            }
        }
    }
    
    func onClickLayer(_ layer: BaseLayer) {
        appData.baseLayerService.current = layer
        self.presentationMode.wrappedValue.dismiss()
    }
}
