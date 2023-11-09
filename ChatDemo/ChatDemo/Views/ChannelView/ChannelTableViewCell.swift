//
//  ChannelTableViewCell.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit

final class ChannelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let cellId: String = "ChannelTableViewCell"
    
    lazy var chatRoomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        
        return label
    }()

    lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    // MARK: - Lifecycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubview(chatRoomLabel)
        contentView.addSubview(detailButton)
        
        chatRoomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(detailButton).offset(-24)
        }
        
        detailButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        detailButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
}
