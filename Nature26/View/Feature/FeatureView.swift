
import SwiftUI

struct FeatureView: View {
    var layer: Layer?
    var feature: Feature
    var flyToFeature: (_: Layer, _: Feature) -> ()
    
    var body: some View {
        if let layer = layer {
            VStack(alignment: .leading) {
                HStack {
                    LayerColorView(color: layer.color)
                    LayerSymbolView(symbol: layer.symbol)
                    
                    Text(feature.name)
                        .bold()
                        .onTapGesture {
                            flyToFeature(layer, feature)
                        }
                }
                
                ForEach(FeatureDescription(html: feature.description).lines, id: \.self) {
                    Text($0.title).bold() + Text($0.text)
                }
            }.padding([.leading, .trailing])
            Divider()
        }
    }
}
