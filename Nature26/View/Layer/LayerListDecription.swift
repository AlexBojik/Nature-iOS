
import SwiftUI
struct LayerListDescription: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        if !appData.layerService.layersDescripton.isEmpty {
            HTMLStringView(htmlContent: appData.layerService.layersDescripton)
        }
    }
}
