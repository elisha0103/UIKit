//
//  ViewController.swift
//  SignUp
//
//  Created by 진태영 on 2023/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var id: UITextField!
    @IBOutlet var pw: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did load")
        self.id.text = User.shared.id
        self.pw.text = User.shared.pw
    }



}

