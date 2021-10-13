
import SwiftUI

struct LayerSymbolView: View {
    var symbol: String?
    
    var body: some View {
        if let symbol = symbol, !symbol.isEmpty {
            Image(symbol).resizable().frame(width: 24, height: 24)
        }
    }
}
