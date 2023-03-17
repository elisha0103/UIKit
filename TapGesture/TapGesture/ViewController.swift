//
//  ViewController.swift
//  TapGesture
//
//  Created by 진태영 on 2023/03/17.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    
//    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()

        tapGesture.delegate = self

        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)

        return false
    }

}

