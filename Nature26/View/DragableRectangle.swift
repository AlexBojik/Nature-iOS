
import SwiftUI

struct DragableRectangle: View {
    
    var onDragEnded: (_: DragGesture.Value) -> Void
    var onDragChanged: (_: DragGesture.Value) -> Void
    
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(width: UIScreen.width / 3, height: 6, alignment: .center)
            .cornerRadius(5)
            .padding(.top)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged(onDragChanged)
                    .onEnded(onDragEnded))
    }
}
