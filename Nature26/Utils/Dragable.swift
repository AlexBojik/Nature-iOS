import SwiftUI

protocol Dragable {
    var size: CGFloat { get set }
    var oldSize: CGFloat { get set }
    
    func onDragEnded(v: DragGesture.Value)
    func onDragChanged(v: DragGesture.Value)
}
