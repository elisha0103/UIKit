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
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    let recentDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = "11월 17일"
        
        return label
    }()
    
    let chatPreviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.text = "오오옹"
        
        return label
    }()
    
    lazy var chatAlartNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        label.text = "000"
        label.layer.masksToBounds = true

        return label
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 8
        stackView.distribution = .fill
        
        return stackView
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
        addSubviews(
            contentStackView,
            infoStackView
        )
        
        updateAlarmLabelSize()
        
        contentStackView.addArrangedSubview(chatRoomLabel)
        contentStackView.addArrangedSubview(chatPreviewLabel)
        
        infoStackView.addArrangedSubview(recentDateLabel)
        infoStackView.addArrangedSubview(chatAlartNumberLabel)
        
        contentStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        contentStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(infoStackView).offset(5)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func updateAlarmLabelSize() {
        chatAlartNumberLabel.snp.makeConstraints {
            let size = setTextLabelSize(label: chatAlartNumberLabel)
            
            $0.width.equalTo(size.0)
            $0.height.equalTo(size.1)
            chatAlartNumberLabel.layer.cornerRadius = size.1 / 2
        }

    }
    
    private func setTextLabelSize(label: UILabel) -> (CGFloat, CGFloat) {
        let size = (label.text as NSString?)?.size() ?? .zero
        let newSize = CGSize(width: size.width + 15, height: size.height + 15)
        return (newSize.width, newSize.height)
    }
    
}
