//
//  DetailViewController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/15.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = url else { return }
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        // Do any additional setup after loading the view.
    }
    


}
