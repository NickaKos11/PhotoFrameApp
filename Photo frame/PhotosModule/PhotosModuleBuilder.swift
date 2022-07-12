import Foundation
import UIKit
final class PhotosModuleBuilder {
    let viewController: PhotosModuleViewController
    private let presenter: PhotosModulePresenter
    var output: PhotosModuleOutput {
        presenter.output
    }
    var input: PhotosModuleInput {
        presenter
    }

    init(output: PhotosModuleOutput, photos: [UIImage]) {
        presenter = PhotosModulePresenter(
            output: output,
            photos: photos
        )
        viewController = PhotosModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
