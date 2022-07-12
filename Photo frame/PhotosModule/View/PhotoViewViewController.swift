import UIKit
import Foundation

protocol PhotosModuleViewInput: AnyObject {

}

protocol PhotosModuleViewOutput: AnyObject {
    func getPhotos() -> [UIImage]
}

final class PhotosModuleViewController: UIViewController {
    
    var indexNumber = 1
    var maxWidth:CGFloat = 0
    var pageWidth:CGFloat = 0
    
    private var output: PhotosModuleViewOutput?
    
    init(output: PhotosModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setupConstraints()
        
        if let data = output?.getPhotos() {
            if data.count != 0 {
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
            }
        }
            
    }
    
    @objc
    func moveToNextPage () {
        
        guard let itemsCount = output?.getPhotos().count else {
            return
        }
        
       let pageWidth:CGFloat = self.collectionView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(itemsCount)
       let contentOffset:CGFloat = self.collectionView.contentOffset.x
        var slideToX: CGFloat = 0
        slideToX = slideToX + contentOffset + pageWidth

       if  contentOffset + pageWidth == maxWidth {
               slideToX = 0
       }

       // collectionView.setContentOffset(CGPoint(x: slideToX, y: 0), animated: true)

        collectionView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.collectionView.frame.height), animated: true)
   }

    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.register(PhotoTextCollectionViewCell.self, forCellWithReuseIdentifier: PhotoTextCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosModuleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output?.getPhotos().count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = output?.getPhotos() {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configure(with: data[indexPath.row])
                return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension PhotosModuleViewController: PhotosModuleViewInput { }
