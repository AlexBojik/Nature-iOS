import SwiftUI

struct LayerIconView: View {
    var icon: String?
    
    var body: some View {
        if let icon = icon, !icon.isEmpty {
            Image(icon).resizable().frame(width: 24, height: 24)
        }
    }
}

