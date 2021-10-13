
import Foundation

protocol IUserService {
    var token: String { get set }
    var userPreference: String { get }
}

class UserService: IUserService {
    private var networkService: INetworkService
    private var user: User?
    
    var token: String {
        didSet {
            self.updateUser()
        }
    }
    
    var userPreference: String {
        return user?.name.uppercased() ?? ""
    }
    
    init(_ networkService: INetworkService) {
        self.networkService = networkService
        self.token = UserDefaults.standard.string(forKey: "token") ?? ""
        self.updateUser()
    }

    private func updateUser() {
        if !self.token.isEmpty {
            networkService.getUser(Config.baseUrl + "user/\(token)") {user in
                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
}
