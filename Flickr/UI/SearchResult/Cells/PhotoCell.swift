//
//  PhotoCell.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let ID = "PhotoCell"
    
    private let imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(
            fontSize: 12,
            color: .mainColor)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        imgView.anchor(
            .top(),
            .leading(),
            .trailing(),
            .heightEqualTo(imgView.widthAnchor))
        
        titleLabel.anchor(
            .leading(),
            .trailing(),
            .top(imgView.bottomAnchor, constant: 5))
  
    }
    
 
    // MARK: - Set data
    func configure(_ viewModel: SearchCellViewModel) {
        titleLabel.text = viewModel.title
        imgView.loadImageFromUrl(viewModel.imagePath)
    }
}

