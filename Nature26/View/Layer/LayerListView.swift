
import SwiftUI

struct LayerListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack {
            TitleTextView(text: Config.layerListName)
            List(appData.layerService.layers, children: \.layers) { layer in
                // checkbox
                HStack {
                    Button(action: { clickLayer(layer) }, label: { Image(systemName: layer.state()) })
                    
                    LayerIconView(icon: layer.icon)
                    LayerColorView(color: layer.color)
                    LayerSymbolView(symbol: layer.symbol)
                    Text(layer.name)
                    
                    Spacer()
                    
                    LayerLoadButtonView(layer: layer)
                }
            }
            Button(action: accept, label: { Text(Config.acceptText) }).padding(.bottom)
        }
    }
    
    func clickLayer(_ layer: Layer) {
        appData.objectWillChange.send()
        layer.toggle()
    }
    
    func accept() {
        appData.layerService.layersChanged = true
        self.presentationMode.wrappedValue.dismiss()
    }
}
