
import AuthenticationServices

class EsiaSignInView: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn(_ handler: @escaping ASWebAuthenticationSession.CompletionHandler) {
        guard let authURL = URL(string: Config.esiaUrl) else { return }
        
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: Config.authScheme, completionHandler: handler)
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }

}
