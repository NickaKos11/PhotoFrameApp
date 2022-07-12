import UIKit
import Foundation

final class PhotoTextCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoTextCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Тут пока пусто. Добавьте фотографии."
        label.textColor = ColorPalette.alternativeTextColor
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 26)
        return label
    }()
    
    func setup() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
