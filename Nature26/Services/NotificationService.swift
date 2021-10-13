
import UserNotifications

protocol INotificationService {
    func showLayerNotification(_ layerNameList: [String])
    func requestPermission()
}

class  NotificationService: INotificationService {
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func showLayerNotification(_ layerNameList: [String]) {
        DispatchQueue.main.async {
            let content = UNMutableNotificationContent()
            content.title = Config.notificationTitle
            content.body = Config.notificationBody + " (\(layerNameList.joined(separator: ", ")))"
            content.sound = UNNotificationSound.default
            let request = UNNotificationRequest(identifier: "warn", content: content, trigger: nil)
            self.notificationCenter.add(request, withCompletionHandler: nil)
        }
    }
    
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound,]
        notificationCenter.requestAuthorization(options: options) {_,_ in }
    }
}
