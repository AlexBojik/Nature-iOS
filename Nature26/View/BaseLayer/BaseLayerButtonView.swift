
import SwiftUI

struct BaseLayerButtonView: View {
    @State var show = false
    var body: some View {
        Button(Icons.baseLayersIcon) { show.toggle() }
        .foregroundColor(.blue)
        .sheet(isPresented: $show) { BaseLayersListView() }
    }
}
