//
//  ViewController.swift
//  Networking
//
//  Created by 진태영 on 2023/04/28.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil
        
        // 백그라운드 스레드에서 다운로드 하도록
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }

            // 다운로드한 이미지를 뷰에 적용하도록
            DispatchQueue.main.async {
                // 다운로드 중 셀의 인덱스 정보가 바뀔 수 있다.(스크롤의 여부로)
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    // index 변수: 다운로드하려는 cell의 인덱스 정보
                    // indexPath: 현재 나타난 새로운 cell의 인덱스 정보
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)

                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    @objc func didRecieveFriendsNotification(_ noti: Notification) {
        
        guard let friends: [Friend] = noti.userInfo?["friends"] as? [Friend] else { return }
        
        self.friends = friends
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friends: [Friend] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveFriendsNotification(_:)), name: DidReceiveFirendsNotification, object: nil)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        requestFriends()
    }

}

