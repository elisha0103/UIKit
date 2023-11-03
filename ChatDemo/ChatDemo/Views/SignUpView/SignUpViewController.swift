//
//  SignUpViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

import SnapKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password: "
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Name: "
        return label
    }()
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc
    func didTapSignUpButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullName = fullNameTextField.text
        else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName)
        
        AuthAPI.shared.registerUser(credentials: credentials) { error in
            if error == nil {
                self.dismiss(animated: true)
            } else if let error = error {
                print("error: ", error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            fullNameLabel,
            fullNameTextField,
            registrationButton
        )
        
        emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(30)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(emailLabel.snp.trailing).offset(10)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.equalTo(passwordLabel.snp.trailing).offset(10)
        }
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
        }
        fullNameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.equalTo(fullNameLabel.snp.trailing).offset(10)
        }
        
        registrationButton.snp.makeConstraints {
            $0.top.equalTo(fullNameTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
