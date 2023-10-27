//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - API
    
    // MARK: - Selectors
    
    @objc
    func didTapButton() {
        navigationController?.setViewControllers([ChannelViewController()], animated: true)
    }
    
    // MARK: - Helpers
    
    
}

