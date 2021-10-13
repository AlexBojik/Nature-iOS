
import CoreLocation

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {}
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}
