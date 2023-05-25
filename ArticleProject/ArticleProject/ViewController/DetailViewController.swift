//
//  DetailViewController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/15.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let urlString = url else { return }
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        self.spinner.alpha = 1
        self.spinner.startAnimating()
        
        
        webView.load(urlRequest)
        // Do any additional setup after loading the view.

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
        self.spinner.alpha = 0
    }
    


}
