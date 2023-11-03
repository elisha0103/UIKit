//
//  AppController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import Firebase

final class AppController {
    
    // MARK: - Properties
    
    static let shared = AppController()
    private var window: UIWindow!
    private var rootViewcontroller: UIViewController? {
        didSet {
            window.rootViewController = rootViewcontroller
        }
    }
    
    // MARK: - Lifecycles
    
    init() {
        FirebaseApp.configure()
        NotificationCenter.default.addObserver(self, selector: #selector(checkSignIn), name: .AuthStateDidChange, object: nil)
    }
    
    // MARK: - Selectors
    
    @objc
    private func checkSignIn() {
        if (Auth.auth().currentUser?.uid) != nil {
            setChannelScene()
        } else {
            setLoginScene()
        }
    }
    
    // MARK: - Helpers
    
    private func setChannelScene() {
        let channelViewController = ChannelViewController()
        rootViewcontroller = BaseNavigationController(rootViewController: channelViewController)
    }
    
    private func setLoginScene() {
        rootViewcontroller = BaseNavigationController(rootViewController: (LoginViewController()))
    }
        
    func show(in window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        self.window = window
        window.tintColor = .primary
        window.backgroundColor = .systemBackground
        checkSignIn()
        window.makeKeyAndVisible()
    }
    
    
    
}
