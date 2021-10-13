import CoreLocation
import Mapbox

struct FlyProperty: Decodable, Hashable {
    static func == (lhs: FlyProperty, rhs: FlyProperty) -> Bool {
        return lhs.center == rhs.center && lhs.bounds == lhs.bounds
    }
    
    typealias Point = Array<CLLocationDegrees>
    typealias Polygon = Array<Array<Point>>
    typealias MultiPolygon = Array<Polygon>
    
    var center: CLLocationCoordinate2D?
    var bounds: MGLCoordinateBounds?
    
    init(from decoder: Decoder) {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self),
              let type =  try? container.decode(String.self, forKey: .type) else { return }
        
        if type == "Point" {
            if let point = try? container.decode(Point.self, forKey: .coordinates),
               point.count == 2 {
                center = CLLocationCoordinate2D(latitude: point[1], longitude: point[0])
            }
        } else {
            var lon_min = CLLocationDegrees(180),
                lon_max = CLLocationDegrees(0),
                lat_min = CLLocationDegrees(90),
                lat_max = CLLocationDegrees(0)
            
            if type == "Polygon",
               let coordinates = try? container.decode(Polygon.self, forKey: .coordinates) {
                coordinates.flatMap { $0 }.forEach { point in
                    if point.count == 2 {
                        lon_min = min(point[0], lon_min)
                        lon_max = max(point[0], lon_max)
                        lat_min = min(point[1], lat_min)
                        lat_max = max(point[1], lat_max)
                    }
                }
            }
            
            if type == "MultiPolygon",
               let coordinates = try? container.decode(MultiPolygon.self, forKey: .coordinates) {
                coordinates.flatMap { $0 }.flatMap { $0 }.forEach { point in
                    if point.count == 2 {
                        lon_min = min(point[0], lon_min)
                        lon_max = max(point[0], lon_max)
                        lat_min = min(point[1], lat_min)
                        lat_max = max(point[1], lat_max)
                    }
                }
            }
            
            bounds = MGLCoordinateBounds(
                sw: CLLocationCoordinate2D(latitude: lat_max, longitude: lon_max),
                ne: CLLocationCoordinate2D(latitude: lat_min, longitude: lon_min))
        }
    }
}

