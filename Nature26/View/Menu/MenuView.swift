
import SwiftUI

struct MenuView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    SearchView()
                    NewsButtonView()
                }
                Spacer()
                VStack {
                    LocationButtonView()
                    SendButtonView()
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                BaseLayerButtonView()
                Spacer()
                LayerButtonView()
            }
            .padding()
        }
        .sheet(isPresented: $appData.showLayerListDescription, onDismiss: { appData.showLayerListDescription = false}) {
            LayerListDescription()
        }
        .buttonStyle(RoundIconButtonStyle())
    }
}
#Preview {
    MenuView()
}
