
struct GeoObject: Decodable {
    var id: Int
    var layerId: Int
    var name: String
    var geoJson: FlyProperty?
    var description: String
}
