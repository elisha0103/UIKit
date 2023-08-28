//
//  ViewController.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let buttonView = ButtonView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(buttonView)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBlue
        
        buttonView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(buttonView.snp.bottom)
        }
    }

}

