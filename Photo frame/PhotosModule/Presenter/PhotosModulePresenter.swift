import UIKit
protocol PhotosModuleInput: AnyObject {
    
}

protocol PhotosModuleOutput: AnyObject {

}


final class PhotosModulePresenter {
    weak var view: PhotosModuleViewInput? {
        didSet {}
    }
    
    var photos: [UIImage] = []
    let output: PhotosModuleOutput
    
    required init(output: PhotosModuleOutput, photos: [UIImage]) {
        self.output = output
        self.photos = photos
    }
}

extension PhotosModulePresenter: PhotosModuleInput {}

extension PhotosModulePresenter: PhotosModuleViewOutput {
    func getPhotos() -> [UIImage] {
        return photos
    }
    
}
