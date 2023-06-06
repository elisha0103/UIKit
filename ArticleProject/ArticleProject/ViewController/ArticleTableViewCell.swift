//
//  ArticleTableViewCell.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/16.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    var articleCell: Article?
    var articleApiProvider: ArticleApiProvider = ArticleApiProvider()
    lazy var cache: NSCache<AnyObject, UIImage> = NSCache()
    lazy var fileManager: FileManager = FileManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func displayArticle(article: Article, forIndexPath indexPath: IndexPath, tableView: UITableView) {
        articleLabel.text = ""
        articleImage.image = nil
        articleCell = article
        
        // cell animation
        articleLabel.alpha = 0
        articleImage.alpha = 0
        
        
        articleLabel.text = articleCell?.title
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.articleLabel.alpha = 1
        }, completion: nil)
        
        // 이미지 url이 없는 기사인 경우,
        guard articleCell?.urlToImage != nil else { return }
        
        // 메모리 캐시가 존재하는 경우
        if let memoryCacheImage = cache.object(forKey: articleCell?.urlToImage as AnyObject) {
            self.articleImage.image = memoryCacheImage
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImage.alpha = 1
            }, completion: nil)
            
            print("Memory Cache Image")
            
            return
        }
        
        let urlString = articleCell?.urlToImage
        guard let url = URL(string: urlString ?? "") else {
            print("ArticleTableViewCell func displayArticle URL Error")
            return
        }
        
        // 디스크 캐시 폴더
        guard let diskCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        var filePath = URL(fileURLWithPath: diskCachePath)
        filePath.appendPathComponent(url.lastPathComponent)
        
        // 디스크 캐시가 있는 경우
        if fileManager.fileExists(atPath: filePath.path) {
            guard let diskCacheData = try? Data(contentsOf: filePath) else {
                print("Disk Cache Data Error")
                
                return
            }
            
            guard let diskCacheImage = UIImage(data: diskCacheData) else {
                print("Disk Cache Image Error")
                
                return
            }
            
            self.articleImage.image = diskCacheImage
            self.cache.setObject(diskCacheImage, forKey: self.articleCell?.urlToImage as AnyObject)

            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImage.alpha = 1
            }, completion: nil)
            
            print("Disk Cache Image")
            
            return
        }
        
        
        // Memory, Disk Cache가 모두 없는 경우
        articleApiProvider.request(url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    // 셀이 재사용되는 경우 셀의 인덱스 정보가 변경되더라도 이미지를 정상적으로 할당해주기 위한 방법
                    if let currentCell = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell, currentCell == self {
                        
                        guard let img: UIImage = UIImage(data: data) else { return }
                        
                        self.articleImage.image = img
                        self.cache.setObject(img, forKey: self.articleCell?.urlToImage as AnyObject)
                        self.fileManager.createFile(atPath: filePath.path(), contents: img.jpegData(compressionQuality: 0.4))
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImage.alpha = 1
                        }, completion: nil)
                    }
                    print("Network Image")
                }
            case .failure(let error):
                print("ArticleTableViewCell func displayArticle Image error: \(error.localizedDescription)")
            }
        }
    }
}
