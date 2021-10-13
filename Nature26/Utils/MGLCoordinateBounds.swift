
import Mapbox

extension MGLCoordinateBounds: Hashable {
    public func hash(into hasher: inout Hasher) { }
    
    public static func == (lhs: MGLCoordinateBounds, rhs: MGLCoordinateBounds) -> Bool {
        return lhs.ne == rhs.ne && lhs.sw == rhs.sw
    }
}
