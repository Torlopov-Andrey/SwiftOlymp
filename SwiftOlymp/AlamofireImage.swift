import Foundation
import AlamofireImage
import Alamofire

struct GrayScaleFilter: ImageFilter {
    
    var filter: (Image) -> Image {
        return { image in
            let parameters: [String: Any] = [
                kCIInputBrightnessKey: 0,
                kCIInputSaturationKey: 0,
                kCIInputContrastKey: 1.1]
            
            return image.af_imageFiltered(withCoreImageFilter: "CIColorControls", parameters: parameters) ?? image
        }
    }
}

extension UIImageView {
    
    func setImage(with urlString: String?,
                  placeholderImage: UIImage? = nil,
                  filter: ImageFilter? = nil,
                  completion: ((DataResponse<UIImage>) -> Void)? = nil) {
        self.image = nil
        if let string = urlString , !string.isEmpty,
            let url = URL(string: string) {
            self.af_setImage(withURL: url,
                             placeholderImage: placeholderImage,
                             filter: filter,
                             completion: completion)
        }
    }
}
