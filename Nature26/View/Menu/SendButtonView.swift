
import SwiftUI
import AuthenticationServices

struct SendButtonView: View {
    @EnvironmentObject var appData: AppData
    @State var show = false
    
    var body: some View {
        if let location = appData.locationService.lastLocation {
            Button(Icons.sendButton) { showSendView() }
            .foregroundColor(.blue)
            .padding(.top)
            .sheet(isPresented: $show) {
                SendView(coordinate: location.coordinate)
            }
        }
    }
    
    func showSendView() {
        if appData.userService.token.isEmpty {
            EsiaSignInView().signIn(signInHandler)
        } else {
            show.toggle()
        }
    }
    
    func signInHandler(url: URL?, error: Error?)  {
        guard error == nil, let url = url else { return }

        if let token = URLComponents(string: url.absoluteString)?.queryItems?.filter({ $0.name == "t" }).first?.value {
            UserDefaults.standard.set(token, forKey: "token")
            appData.userService.token = token
        }
    }
}
