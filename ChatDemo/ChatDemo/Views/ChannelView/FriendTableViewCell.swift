//
//  FriendTableViewCell.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let cellId = "FriendTableViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    // MARK: - Lifecycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .systemBackground
        addSubviews(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
