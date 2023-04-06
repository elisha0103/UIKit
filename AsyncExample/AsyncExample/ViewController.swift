//
//  ViewController.swift
//  AsyncExample
//
//  Created by 진태영 on 2023/04/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        // 이미지 다운로드 -> 이미지 뷰에 셋팅
        
        // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwUVtrBkYCDz_bxgKCIgzsU0aeKWMQAFckRv33exkzT0sjZqL3CkoQcIM6x85-dlmZ-KY&usqp=CAU
        
        let imageURL: URL = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwUVtrBkYCDz_bxgKCIgzsU0aeKWMQAFckRv33exkzT0sjZqL3CkoQcIM6x85-dlmZ-KY&usqp=CAU")!
        
        
        OperationQueue().addOperation {
            let imageData: Data = try! Data.init(contentsOf: imageURL)
            let image: UIImage = UIImage(data: imageData)!
            
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

