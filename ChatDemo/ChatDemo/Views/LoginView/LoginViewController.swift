//
//  LoginViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit
import FirebaseAuth
import FirebaseMessaging

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.placeholder = "이메일"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.delegate = self
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.textColor = .label
        textField.placeholder = "비밀번호 입력"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
       let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }

    // MARK: - API
    
    // MARK: - Selectors
    
    @objc
    func didTapButton() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        AuthAPI.shared.logUserIn(withEmail: email, password: password) { _, _ in
            
        }
    }
    
    @objc
    func didTapSignUpButton() {
        present(SignUpViewController(), animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(loginButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-56)
            $0.centerX.equalToSuperview()
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
    }
}

