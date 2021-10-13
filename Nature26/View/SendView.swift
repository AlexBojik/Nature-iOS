
import SwiftUI
import CoreLocation

struct SendView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    
    @State var sending = false
    @State var showAlert = false
    @State var showImagePicker = false
    
    @State var text: String = ""
    @State var images: [UIImage] = []
    
    @State var image: UIImage?
    
    @State var alertMessage: String = Config.errorMessage
    
    var coordinate: CLLocationCoordinate2D
    var body: some View {
        if sending {
            ProgressView()
        }
        
        VStack {
            TitleTextView(text: Config.sendingTitle)
            TitleTextView(text: appData.userService.userPreference, font: .title3)
            
            TextEditor(text: $text).border(Color.gray)
            
            Text("\(Config.coordinatesText): \(coordinate.latitude), \(coordinate.longitude)").bold()
            
            ImageStackeView(images: images, action: toggleShowImagePicker, sendAction: send)
        }
        .padding()
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePickerView(image: $image)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(Config.sendingTitle),
                message: Text(self.alertMessage),
                dismissButton: .cancel(Text(Config.okText), action: dismiss))
        }
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func loadImage() {
        guard let image = image else { return }
        self.images.append(image)
    }
    
    func toggleShowImagePicker() {
        self.showImagePicker.toggle()
    }
    
    func send() {
        guard !text.isEmpty else { return }
        
        let message = UserMessage(images: images, text: text, token: appData.userService.token)
        sending = true
        appData.networkService.sendUserMessage(Config.baseUrl + "send", message, afterSendMessage)
    }
    
    func afterSendMessage(_ number: Int?) {
        guard let number = number else { return }
        
        DispatchQueue.main.async {
            sending = false
            if (number > 0) {
                alertMessage = "\(Config.thankForMessage) \(number)!"
            }
            showAlert = true
        }
    }
}
