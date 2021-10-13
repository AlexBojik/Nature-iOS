
import SwiftUI

struct LocationButtonView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        Button(Icons.location) { appData.flyToLocationIsActive = true }
        .padding(.top, 60)
        .foregroundColor(.blue)
    }
}
