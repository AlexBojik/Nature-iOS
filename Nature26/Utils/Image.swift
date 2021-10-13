
import SwiftUI

extension Image {
    init(_ icon: Icons) {
        self.init(systemName: icon.rawValue)
    }
}
