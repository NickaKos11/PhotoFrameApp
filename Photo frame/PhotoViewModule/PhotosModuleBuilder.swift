import Foundation
final class PhotosModuleBuilder {
    let viewController: PhotosModuleViewController
    private let presenter: PhotosModulePresenter
    var output: PhotosModuleOutput {
        presenter.output
    }
    var input: PhotosModuleInput {
        presenter
    }

    init(output: PhotosModuleOutput) {
        presenter = PhotosModulePresenter(
            output: output
        )
        viewController = PhotosModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
