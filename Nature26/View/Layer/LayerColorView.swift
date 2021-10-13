
import SwiftUI

struct LayerColorView: View {
    var color: String?
    
    var body: some View {
        if let color = color, !color.isEmpty {
            Rectangle().fill(Color(hex: color)).frame(width: 16, height: 16)
        }
    }
}
