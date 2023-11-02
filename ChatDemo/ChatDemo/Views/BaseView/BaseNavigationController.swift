//
//  BaseNavigationController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyle()
    }
    
    // MARK: - Helpers
    
    private func setupNavigationBarStyle() {
        let mainColor = UIColor.label
        navigationBar.tintColor = mainColor
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor: mainColor]
    }
    
}
