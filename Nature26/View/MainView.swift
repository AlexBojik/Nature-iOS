
import SwiftUI

struct MainView: View {
    private let appData = AppData()
    
    var body: some View {
        ZStack {
            MapboxView()
            MenuView()
            FeatureListView()
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(appData)
    }
}
