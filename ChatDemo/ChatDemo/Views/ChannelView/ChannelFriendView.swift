//
//  ChannelFriendView.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

import SnapKit

class ChannelFriendView: BaseViewController {
    
    // MARK: - Properties
    
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
                let result = snapshot?.documents else { return }
            self.friendUser = result.map { User(uid: $0.documentID, dictionary: $0.data())}
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
