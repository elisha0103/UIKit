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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayArticle(article: Article) {
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
        
        let urlString = articleCell?.urlToImage
        guard let url = URL(string: urlString ?? "") else {
            print("ArticleTableViewCell func displayArticle URL Error")
            return
        }
        
        articleApiProvider.request(url) { result in
            switch result {
            case .success(let data):
                if self.articleCell?.urlToImage == urlString {
                    DispatchQueue.main.async {
                        self.articleImage.image = UIImage(data: data)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImage.alpha = 1
                        }, completion: nil)
                    }
                }
                break
            case .failure(let error):
                print("ArticleTableViewCell func displayArticle Image error: \(error.localizedDescription)")
            }
        }
            
        
    }

}
