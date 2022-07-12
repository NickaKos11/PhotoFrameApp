import UIKit
import Foundation

final class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var photoImageView: UIImageView = {
        let lessonImageView = UIImageView()
        lessonImageView.tintColor = .red
        lessonImageView.translatesAutoresizingMaskIntoConstraints = false
        lessonImageView.contentMode = .scaleAspectFit
        return lessonImageView
    }()
    
    func setup() {
        contentView.addSubview(photoImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage) {
        photoImageView.image = image
    }
}
