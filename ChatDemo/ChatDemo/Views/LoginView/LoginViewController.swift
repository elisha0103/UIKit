//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.placeholder = "이름 입력"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.delegate = self
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.becomeFirstResponder()
    }

    // MARK: - API
    
    // MARK: - Selectors
    
    @objc
    func didTapButton() {
        guard let name = nameTextField.text else { return }
        UserDefaultManager.displayName = name
        Auth.auth().signInAnonymously()
    }
}

