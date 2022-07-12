import Foundation
import UIKit

final class AppCoordinator {
    lazy var photoPickerController: PhotoPickerModuleViewController = {
        return self.photoPickerModuleBuilder().viewController
    }()
    
    private func presentPhotosModule(on viewController: UIViewController, photos: [UIImage]) {
        let photosModule = photosModuleBuilder(photos: photos)
        viewController.present(photosModule.viewController, animated: true, completion: nil)
    }
}

extension AppCoordinator {
        
    private func photosModuleBuilder(photos: [UIImage]) -> PhotosModuleBuilder {
        PhotosModuleBuilder(
            output: self,
            photos: photos
        )
    }
    
    private func photoPickerModuleBuilder() -> PhotoPickerModuleBuilder {
        PhotoPickerModuleBuilder(
            output: self
        )
    }
}

extension AppCoordinator: PhotosModuleOutput  { }


extension AppCoordinator: PhotoPickerModuleOutput  {
    func photosModule(on viewController: UIViewController, photos: [UIImage]) {
        presentPhotosModule(on: viewController, photos: photos)
    }
}
