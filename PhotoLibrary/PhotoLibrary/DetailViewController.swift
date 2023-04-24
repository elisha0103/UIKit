//
//  DetailViewController.swift
//  PhotoLibrary
//
//  Created by 진태영 on 2023/04/24.
//

import UIKit
import Photos

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var album: Album!
    var asset: UIImage!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = asset
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
    }
    
    @IBAction func trashbtClick(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets([self.album.asset[self.index]] as NSArray)
        }
        
        OperationQueue.main.addOperation {
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    // 줌 할 뷰 지정
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // 줌 시작시 배경 검은색으로 변경
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.backgroundColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.toolbar.isHidden = true
    }
    
    // 줌 끝날 대 원래 사이즈로 돌아왔으면ㄴ 다시 배경 흰색으로
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            scrollView.backgroundColor = UIColor.white
            
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.toolbar.isHidden = false
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
