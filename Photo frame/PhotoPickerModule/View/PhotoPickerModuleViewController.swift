import UIKit
import Foundation
import PhotosUI

protocol PhotoPickerModuleViewInput: AnyObject {

}

protocol PhotoPickerModuleViewOutput: AnyObject {
    func addPhoto(photo: UIImage)
    func viewPhotoButtonPressed(on viewController: UIViewController)
    func deleteOldPhotos()
}

final class PhotoPickerModuleViewController: UIViewController {
    let sideIndent: CGFloat = 48
    let bigIndent: CGFloat = 160
    private var output: PhotoPickerModuleViewOutput?
    
    init(output: PhotoPickerModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [logoImageView,
         choosePhotoButton,
         viewPhotoButton
        ].forEach {
           view.addSubview($0)
        }
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private lazy var pickerViewController: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = PHPickerFilter.images
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        return pickerViewController
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.tintColor = .lightGray
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "girl")
        return logoImageView
    }()
    
    private lazy var choosePhotoButton: UIButton = {
        let choosePhotoButton = UIButton()
        choosePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        choosePhotoButton.layer.cornerRadius = 13
        choosePhotoButton.layer.masksToBounds = true
        choosePhotoButton.setTitle("Выбрать фото", for: .normal)
        choosePhotoButton.backgroundColor = ColorPalette.buttonsColor
        choosePhotoButton.setTitleColor(ColorPalette.textColor, for: .normal)
        choosePhotoButton.titleLabel?.font = UIFont(name: "SFPro-Regular", size: 18)
        choosePhotoButton.addTarget(self, action: #selector(presentPicker), for: .touchUpInside)
        return choosePhotoButton
    }()
    
    private lazy var viewPhotoButton: UIButton = {
        let viewPhotoButton = UIButton()
        viewPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        viewPhotoButton.layer.cornerRadius = 13
        viewPhotoButton.layer.masksToBounds = true
        viewPhotoButton.setTitle("Просмотреть фото", for: .normal)
        viewPhotoButton.backgroundColor = ColorPalette.buttonsColor
        viewPhotoButton.setTitleColor(ColorPalette.textColor, for: .normal)
        viewPhotoButton.titleLabel?.font = UIFont(name: "SFPro-Regular", size: 18)
        viewPhotoButton.addTarget(self, action: #selector(viewPhotoButtonPressed), for: .touchUpInside)
        return viewPhotoButton
    }()
    
    @objc
    func presentPicker() {
       // output?.deleteOldPhotos()
        self.present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc
    func viewPhotoButtonPressed() {
        output?.viewPhotoButtonPressed(on: self)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewPhotoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            viewPhotoButton.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: -bigIndent),
            viewPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideIndent),
            viewPhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideIndent),
            viewPhotoButton.heightAnchor.constraint(equalToConstant: 40),
            choosePhotoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            choosePhotoButton.bottomAnchor.constraint(equalTo: viewPhotoButton.topAnchor, constant: -16),
            choosePhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideIndent),
            choosePhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideIndent),
            choosePhotoButton.heightAnchor.constraint(equalToConstant: 40),
 
        ])
    }
}

extension PhotoPickerModuleViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        output?.deleteOldPhotos()
        
        
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
               result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {[weak self] (object, error) in
                  if let image = object as? UIImage {
                     DispatchQueue.main.async {
                         self?.output?.addPhoto(photo: image)
                     
                     }
                  }
               })
            }
        }
     }
}

extension PhotoPickerModuleViewController: PhotoPickerModuleViewInput { }
