
import SwiftUI

extension Button where Label == Image {
    init(_ iconName: Icons, action: @escaping () -> Void) {
        self.init(action: action, label: {
            Image(systemName: iconName.rawValue)
        })
    }
}
