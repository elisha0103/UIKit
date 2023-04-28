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
        
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return cell }
        guard let imageData: Data = try? Data(contentsOf: imageURL) else { return cell }
        
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friends: [Friend] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        // dataTask는 런타임에 해당 부분을 해석할 때 바로 실행되는 구문이 아니다.
        // dataTask는 URLSession에 대한 정의를 한 것이라고 볼 수 있다.
        // URLSession에 요청을 보내고 응답이 오면 다음과 같은 내용을 수행한다~ 라고 정의한 것
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friends = apiResponse.results
                self.tableView.reloadData()
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        // 실제 dataTask를 실행하는 구문은 바로 resume()에서 수행한다.
        dataTask.resume()
    }


}

