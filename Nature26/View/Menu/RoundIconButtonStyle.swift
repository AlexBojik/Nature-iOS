
import SwiftUI

struct RoundIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 48, height: 48)
            .background(Color(.secondarySystemBackground))
            .clipShape(Circle())
            .shadow(color: .black, radius: 1, x: 0, y: 0)
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
