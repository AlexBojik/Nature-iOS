
import SwiftUI
import WebKit

struct FeatureListView: View {
    @EnvironmentObject var appData: AppData
    
    @State var size: CGFloat = UIScreen.height / 2
    @State var oldSize = UIScreen.height / 2
    
    var body: some View {
        VStack {
            Spacer()
            
            if !appData.featureService.features.isEmpty || appData.featureService.loading {
                VStack {
                    DragableRectangle(onDragEnded: onDragEnded, onDragChanged: onDragChanged)
                    if appData.featureService.loading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: nil) {
                                ForEach(appData.featureService.features, id: \.self) { feature in
                                    FeatureView(
                                        layer: appData.layerService.getLayer(feature.layerId),
                                        feature: feature,
                                        flyToFeature: flyToFeature)
                                }
                            }
                        }
                    }
                }
                .frame(minWidth: UIScreen.width, maxHeight: size)
                .background(Color(.secondarySystemBackground))
            }
        }
    }
}

