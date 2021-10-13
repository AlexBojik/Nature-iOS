
import SwiftUI

struct TitleTextView: View {
    @State var text: String
    @State var font: Font = .title
    var body: some View {
        Text(text)
            .font(font)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}
