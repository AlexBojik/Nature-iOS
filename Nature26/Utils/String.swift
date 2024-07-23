import Foundation

extension String {
    var htmlString: String {
        let data = Data(self.utf8)
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        return attributedString?.string ?? ""
    }
    var nsRange: NSRange {
        return NSRange(self.startIndex..<self.endIndex, in: self)
    }
}
