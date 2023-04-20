//
//  ViewController.swift
//  FriendsCollection
//
//  Created by 진태영 on 2023/04/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    var numberOfCell: Int = 10
    var friends: [Friend] = []
    var cellIdentifier: String = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    // collectionView에 아이템 몇개 놓을 건지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    // collectionView에 특정 cell을 반환함
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FriendsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FriendsCollectionViewCell
        
        let friend: Friend = self.friends[indexPath.item]
        
        cell.nameAgeLabel.text = friend.nameAndage
        cell.adressLabel.text = friend.fullAddress
        
        return cell
    }
    
    // collectionView에 동작 추가(기능)
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.numberOfCell += 1
//        collectionView.reloadData()
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }
        
        do {
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.collectionView.reloadData()
    }


}

