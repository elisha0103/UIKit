//
//  HeaderView.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/29.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
