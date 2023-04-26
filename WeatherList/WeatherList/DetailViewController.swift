//
//  DetailViewController.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/26.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    var city: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationItem.title = city
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
