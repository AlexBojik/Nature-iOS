
import UIKit

struct FeatureDescription: Encodable {
    var lines: [FeatureDescriptionLine] = []
    
    init(html: String) {
        html.components(separatedBy: "<br>").forEach { line in
            let separatedLine = line.components(separatedBy: "</strong>")
            
            if var title = separatedLine.first, let text = separatedLine.last {
                title = title.replacingOccurrences(of: "<strong>", with: "")
                lines.append(FeatureDescriptionLine(title: title, text: text))
            }
        }
    }
}

struct FeatureDescriptionLine: Encodable, Hashable {
    var title: String
    var text: String
}
