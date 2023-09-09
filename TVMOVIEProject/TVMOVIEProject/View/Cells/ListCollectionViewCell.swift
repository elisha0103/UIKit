//
//  ListCollectionViewCell.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import UIKit
import SnapKit
import Kingfisher

class ListCollectionViewCell: UICollectionViewCell {
    static let id = "ListCollectionViewCell"
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
       addSubview(imageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(title: String, releaseDate: String, imageURL: String) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        imageView.kf.setImage(with: URL(string: imageURL))
    }
}
