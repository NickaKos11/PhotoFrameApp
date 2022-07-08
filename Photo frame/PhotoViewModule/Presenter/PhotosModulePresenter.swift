protocol PhotosModuleInput: AnyObject {
    
}

protocol PhotosModuleOutput: AnyObject {

}


final class PhotosModulePresenter {
    weak var view: PhotosModuleViewInput? {
        didSet {}
    }
    
    let output: PhotosModuleOutput
    
    required init(output: PhotosModuleOutput) {
        self.output = output
    }
}

extension PhotosModulePresenter: PhotosModuleInput {}

extension PhotosModulePresenter: PhotosModuleViewOutput {}
