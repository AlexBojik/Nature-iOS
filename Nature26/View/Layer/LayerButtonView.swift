
import SwiftUI

struct LayerButtonView: View {
    @State var show = false
    var body: some View {
        Button(Icons.layersIcon) { show.toggle() }
        .foregroundColor(.blue)
        .sheet(isPresented: $show) { LayerListView() }
    }
}
