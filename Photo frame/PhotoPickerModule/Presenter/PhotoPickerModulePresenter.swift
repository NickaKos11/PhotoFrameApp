import UIKit
protocol PhotoPickerModuleInput: AnyObject {
    
}

protocol PhotoPickerModuleOutput: AnyObject {
    func photosModule(on viewController: UIViewController, photos: [UIImage])
}


final class PhotoPickerModulePresenter {
    var photos: [UIImage] = []
    
    weak var view: PhotoPickerModuleViewInput? {
        didSet {}
    }
    
    let output: PhotoPickerModuleOutput
    
    required init(output: PhotoPickerModuleOutput) {
        self.output = output
    }
}

extension PhotoPickerModulePresenter: PhotoPickerModuleInput {}

extension PhotoPickerModulePresenter: PhotoPickerModuleViewOutput {
    func deleteOldPhotos() {
        photos.removeAll()
    }
    
    func viewPhotoButtonPressed(on viewController: UIViewController) {
        output.photosModule(on: viewController, photos: photos)
    }
    
    func addPhoto(photo: UIImage) {
        photos.append(photo)
    }
    

}
