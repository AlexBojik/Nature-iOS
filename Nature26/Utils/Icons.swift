enum Icons: String {
    case selectedRadioButton = "smallcircle.fill.circle"
    case unselectedRadioButton = "circle"
    case baseLayersIcon = "square.on.square.dashed"
    case location = "location.circle"
    case layersIcon = "square.fill.on.square"
    case searchIcon = "magnifyingglass"
    case sendButton = "square.and.arrow.up"
    case newsIcon = "exclamationmark.triangle"
    case load = "icloud.and.arrow.down"
    
    static func radioButtonIcon(_ selected: Bool) -> Icons {
        return selected ? Icons.selectedRadioButton : Icons.unselectedRadioButton
    }
}
