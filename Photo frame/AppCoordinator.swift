import Foundation
import UIKit

final class AppCoordinator {
    lazy var photosController: PhotosModuleViewController = {
        return self.photosModuleBuilder().viewController
    }()
}

extension AppCoordinator {
        
    private func photosModuleBuilder() -> PhotosModuleBuilder {
        PhotosModuleBuilder(
            output: self
        )
    }
}

extension AppCoordinator: PhotosModuleOutput  { }
