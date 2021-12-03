//
//  PhotoCollectionView.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

protocol PhotoCollectionViewDelegate: AnyObject {
    func scrollViewDidScrollToBottom()
}

class PhotoCollectionView: UIView {
    
    weak var delegate: PhotoCollectionViewDelegate?
    
    private let padding: CGFloat = 16
    private let space: CGFloat = 15
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel(
            fontSize: 16,
            color: .grayColor,
            alignment: .center)
        label.text = "No Photos Found"
        return label
    }()
    
    private lazy var flowFlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        layout.sectionInset = .zero
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: flowFlayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(
            horizontalInset: 0, verticalInset: 0)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .mainBGColor
        return collectionView
    }()

    var dataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setupUI() {
        collectionView.registerCell( PhotoCell.self,
                                     identifier: PhotoCell.ID)
        
        collectionView.registerCell( LoadingCell.self,
                                     identifier: LoadingCell.ID)
        
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        self.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.anchor(
            .top(),
            .leading(15),
            .trailing(-15),
            .bottom())
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }

    func scrollToItem(at item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
    }

    func animateSpinner(_ animate: Bool) {
        let loadingCellIndex = IndexPath(item: 0, section: 1)
            
        guard let cell = collectionView.cellForItem(at: loadingCellIndex) as? LoadingCell
        else { return }
        cell.animateSpinner(animate)
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.color = .mainColor
            activityView.startAnimating()
            self.collectionView.backgroundView = activityView
        }
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = nil
        }
    }
    
    func showEmptyView() {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = self.emptyStateLabel
        }
    }
}

extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeFrame = safeAreaLayoutGuide.layoutFrame.width
        let contentFrame = safeFrame - padding * 2
        let itemCount: CGFloat = safeFrame > 538 ? 4 : 2
        let itemsFrame = contentFrame - space * (itemCount - 1)
        let itemWidth: CGFloat = itemsFrame / itemCount
        let itemHeight = itemWidth + 20
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let loadingWidth = contentFrame
        let loadingSize = CGSize(width: loadingWidth, height: 40)
        return indexPath.section == 0 ? itemSize : loadingSize
    }

}


extension PhotoCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLastCell(scrollView) {
            self.delegate?.scrollViewDidScrollToBottom()
        }
    }
    
    private func isLastCell(_ scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let maximumOffset = contentSizeHeight - scrollViewHeight
        return currentOffset >= 0 && currentOffset >= maximumOffset
    }

}
