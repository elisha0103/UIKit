//
//  BannerCollectionViewCell.swift
//  ModernCollectionProject
//
//  Created by 진태영 on 2023/08/25.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCell"
    let titleLabel = UILabel()
    let backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints({ $0.center.equalToSuperview() })
        backgroundImageView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    public func config(title: String, imageUrl: String) {
        // TODO: - title, image
        titleLabel.text = title
        let url = URL(string: imageUrl)
        backgroundImageView.kf.setImage(with: url)
    }
}
