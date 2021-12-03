//
//  SearchHistoryCell.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

class SearchHistoryCell: UITableViewCell {
    
    static let ID = "SearchHistoryCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel(
            fontSize: 14,
            color: .mainColor)
        return label
    }()
    
    private let clockIcon: UIImageView = {
        let imageView = UIImageView(named: "clock-icon")
        return imageView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(clockIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineView)
    }
    
    private func setConstraints() {
        clockIcon.anchor(
            .centerY(),
            .leading(),
            .width(10),
            .height(10))
        
        titleLabel.anchor(
            .top(5),
            .trailing(),
            .leading(clockIcon.trailingAnchor, constant: 5))
        
        lineView.anchor(
            .leading(),
            .trailing(),
            .height(0.5),
            .bottom(),
            .top(titleLabel.bottomAnchor, constant: 5))
    }
    
    
    // MARK: - Set data
    
    func configure(_ text: String) {
        titleLabel.text = text
    }

}

