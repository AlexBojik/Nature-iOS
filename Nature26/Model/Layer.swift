
import SwiftUI
import Mapbox

enum LayerStates: String {
    case unchecked = "square"
    case undefined = "minus.square"
    case checked = "checkmark.square"
}

class Layer: Codable, Identifiable {
    var id: Int
    var name: String
    var isGroup: Bool
    var group: Int?
    var type: String?
    var url: String?
    var color: String?
    var commonName: String?
    var commonDescription: String?
    var symbol: String?
    var icon: String?
    var layers: [Layer]?
    var lineColor: String?
    var lineWidth: Int?
    var cluster: Bool?
    var warning: Bool?
    
    lazy var visible = false
    lazy var loading = false
    lazy var clusterLoading = false
    
    var pointIdentifier: String {
        return "layer\(self.id)-point"
    }
    
    var clusterIdentifier: String {
        return "layer\(self.id)-cluster"
    }
    
    var lineIdentifier: String {
        return "layer\(self.id)-line"
    }
    
    var identifier: String {
        return "layer\(self.id)"
    }
    
    var fillColorUI: UIColor? {
        guard let color = self.color, !color.isEmpty else { return nil }
        
        return UIColor(Color(hex: color))
    }
    
    var lineColorUI: UIColor? {
        guard let color = self.lineColor, !color.isEmpty else { return nil }
        
        return UIColor(Color(hex: color))
    }
    
    func toggle() {
        self.visible.toggle()
        self.layers?.forEach{ $0.visible = self.visible }
    }
    
    func state() -> String {
        var res: LayerStates = self.visible == true ? .checked : .unchecked
        
        if let children = self.layers {
            // all, any states
            let states = children.reduce((true, false), { ($0.0 && $1.visible, $0.1 || $1.visible) })
            self.visible = states.0
            
            res = states.0 ? .checked : states.1 ? .undefined : .unchecked
        }
        
        return res.rawValue
    }
}

class LayerListApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String, token: String?) {
        if let url = URL(string: urlString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.setValue(token, forHTTPHeaderField: "Token")
        }
    }
}

class LayerApiRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(urlString: String, layer: Layer) {
        if let url = URL(string: urlString + "/\(layer.id)") {
            urlRequest = URLRequest(url: url)
        }
    }
}

class LayerParser: IParser {
    typealias Model = MGLShape
    
    func parse(data: Data) -> Model? {
        guard let result = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return result
    }
}

class LayerListParser: IParser {
    typealias Model = [Layer]
    
    func parse(data: Data) -> Model? {
        let result = try? JSONDecoder().decode(Model.self, from: data)
        return result
    }
}
