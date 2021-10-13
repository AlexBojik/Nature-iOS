
import SwiftUI

struct SearchFieldView: View {
    @Binding var search: String
    
    var onCommit: () -> Void
    
    var body: some View {
        TextField(Config.searchText, text: $search, onCommit: onCommit)
            .padding(10)
            .frame(height: 48)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle()))
            .animation(.easeIn)
            .keyboardType(.default)
            .padding(.top, 60)
    }
}
