
import SwiftUI

struct ButtonImageView: View {
    var image: Image
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action, label: {
           image.resizable().frame(width: 40, height: 40)
        }).cornerRadius(5.0)
    }
}
