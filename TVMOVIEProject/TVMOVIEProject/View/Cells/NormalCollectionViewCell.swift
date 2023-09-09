//
//  NormalCollectionViewCell.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import UIKit
import SnapKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
    
    static let id = "NormalCollectionViewCell"
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let reviewLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: - Label들을 Stack으로 묶어서 코드 변경하기
    private func configureUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(reviewLabel)
        addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(title: String, review: String, description: String, imageURL: String) {
        imageView.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text =  description
    }
}
