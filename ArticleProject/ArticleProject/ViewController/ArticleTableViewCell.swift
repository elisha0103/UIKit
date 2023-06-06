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
        
        if let cacheImage = cache.object(forKey: articleCell?.urlToImage as AnyObject) {
            // 캐시가 존재하는 경우
            self.articleImage.image = cacheImage
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImage.alpha = 1
            }, completion: nil)
            
            print("cache Image")
        } else {
            let urlString = articleCell?.urlToImage
            guard let url = URL(string: urlString ?? "") else {
                print("ArticleTableViewCell func displayArticle URL Error")
                return
            }
            
            articleApiProvider.request(url) { result in
                switch result {
                case .success(let data):
                        DispatchQueue.main.async {
                            
                            // 셀이 재사용되는 경우 셀의 인덱스 정보가 변경되더라도 이미지를 정상적으로 할당해주기 위한 방법
                            if let currentCell = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell, currentCell == self {

                            guard let img: UIImage = UIImage(data: data) else { return }
                            
                            self.articleImage.image = img
                            self.cache.setObject(img, forKey: self.articleCell?.urlToImage as AnyObject)
                            
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

}
