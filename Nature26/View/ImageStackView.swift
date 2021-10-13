
import SwiftUI
import AVFoundation

struct ImageStackeView: View {
    var images: [UIImage] = []
    var action: () -> Void
    var sendAction: () -> Void

    var body: some View {
        HStack {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                ButtonImageView(image: Image(systemName: "plus.app"), action: action)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images, id: \.self) { image in
                            ButtonImageView(image: Image(uiImage: image))
                        }
                    }
                }
            }
            Spacer()
            Button(action: sendAction, label: { Text(Config.sendText).bold() })
        }
    }
}
