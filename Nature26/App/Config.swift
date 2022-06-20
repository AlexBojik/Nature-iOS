import UIKit
import CoreLocation

enum Config {
    static let okText = "OK"
    static let layerListName = "Слои с данными"
    static let baseLayerListName = "Базовые слои"
    static let sendingTitle = "Отправка обращения"
    static let acceptText = "Применить"
    static let sendText = "Отправить"
    static let searchText = "Поиск"
    static let notificationTitle = "Приближение к территории"
    static let notificationBody = "Вы приближаетесь к территориям с особыми условиями нахождения в них посмотрите подробную информацию в приложении"
    static let coordinatesText = "Координаты"
    static let errorMessage = "Не удалось отправить обращение!"
    static let thankForMessage = "Спасибо за обращение! Ваша заявка зарегистрирована под номером"
    static let imageWidth: CGFloat = 1024
    static let compressionQuality: CGFloat = 0
    static let centerCoordinate = CLLocationCoordinate2D(latitude: 45.0454764, longitude: 41.9683431)
    static let zoomLevel = 13.0
    static let tileSize = 256
    static let maximumZoomLevel = 18.6
    static let esiaUrl = "https://nature.mpr26.ru/api/auth"
    static let baseUrl = "https://nature.mpr26.ru/api/"
    static let authScheme = "nature26"
    static let images = ["fish", "san", "pit", "tech", "rekr", "dam", "resh", "cont", "reddozer", "greendozer", "min", "hands", "list", "planet", "tree", "simpletree", "duck"]
    static let defaultBase = BaseLayer(
        id: 2,
        name: "bing",
        url: "https://ecn.t0.tiles.virtualearth.net/tiles/a{quadkey}.jpeg?g=0",
        description: "Bing",
        minZoom: 1,
        maxZoom: 18.2)
    static let style = Bundle.main.url(forResource: "background", withExtension: "json")
}
