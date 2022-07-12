import Foundation
final class PhotoPickerModuleBuilder {
    let viewController: PhotoPickerModuleViewController
    private let presenter: PhotoPickerModulePresenter
    var output: PhotoPickerModuleOutput {
        presenter.output
    }
    var input: PhotoPickerModuleInput {
        presenter
    }

    init(output: PhotoPickerModuleOutput) {
        presenter = PhotoPickerModulePresenter(
            output: output
        )
        viewController = PhotoPickerModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
