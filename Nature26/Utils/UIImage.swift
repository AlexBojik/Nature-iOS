
import UIKit

extension UIImage: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(
            self.resizeWith(width: Config.imageWidth)?
                .jpegData(compressionQuality: Config.compressionQuality)?
                .base64EncodedString(),
            forKey: .jpeg)
    }
    
    func resizeWith(width: CGFloat) -> UIImage? {
        let height = width / size.width * size.height
        let newSize = CGSize(width: width, height: height)
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: newSize))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        UIGraphicsEndImageContext()
        
        return result
    }
}
