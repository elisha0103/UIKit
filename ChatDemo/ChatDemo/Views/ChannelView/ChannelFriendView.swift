//
//  ChannelFriendView.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

import SnapKit
import Firebase

class ChannelFriendView: BaseViewController {
    
    // MARK: - Properties
    var currentUser: User?
    var friendUser: [User] = []
    let channelAPI = ChannelAPI()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.cellId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    // MARK: - Lifecycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    // MARK: - API
    
    func fetchUsers() {
        AuthAPI.shared.fetchUsers { [weak self] snapshot, error in
            if let error = error {
                print("DEBUG - FetchUsers Error: ", #function, error.localizedDescription)
            }
            guard let self = self,
                  let currentUserUid = Auth.auth().currentUser?.uid,
                let result = snapshot?.documents else { return }
            result.forEach { [weak self] result in
                let user = User(uid: result.documentID, dictionary: result.data())
                user.uid == currentUserUid ? self?.currentUser = user : self?.friendUser.append(user)
            }
            print("friendUser: \(friendUser)")
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
