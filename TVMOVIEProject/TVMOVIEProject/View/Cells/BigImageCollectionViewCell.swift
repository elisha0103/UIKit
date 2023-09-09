//
//  BigImageCollectionViewCell.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import UIKit
import SnapKit
import Kingfisher

class BigImageCollectionViewCell: UICollectionViewCell {
    static let id = "BigImageCollectionViewCell"
    
    private let posterImageView = UIImageView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   reviewLabel,
                                                   descriptionLabel])
        stack.axis = .vertical
        addSubview(posterImageView)
        addSubview(stack)
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(14)
            make.trailing.bottom.equalToSuperview().offset(-14)
        }
        
    }
    
    func configure(title: String, overView: String, review: String, posterURL: String) {
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text = overView
        posterImageView.kf.setImage(with: URL(string: posterURL))
    }
    
}
