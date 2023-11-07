//
//  ChannelViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit
import Firebase
import FirebaseAuth

class ChannelViewController: BaseViewController {
    
    // MARK: - Properties
    
    var channels: [Channel] = []
    var currentUser: User?
    private let channelAPI = ChannelAPI()
    private var currentChannelAlertController: UIAlertController?
    
    lazy var channelTableView: UITableView = {
        let view = UITableView()
        view.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.cellId)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Channels"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEBUG - Deinit (channelViewController)")
        channelAPI.removeListener()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        configureUI()
        fetchUser()
        addToolBarItems()
        setupListener()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI()
    }
    
    // MARK: - API
    
    private func setupListener() {
        channelAPI.subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.updateCell(to: data)
            case .failure(let error):
                print("DEBUG - setupListener Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchUser() {
        let uid: String = Auth.auth().currentUser?.uid ?? UUID().uuidString
        let fcmToken = UserDefaults.standard.string(forKey: "FCMToken") ?? ""
        
        AuthAPI.shared.updateFCMTokenAndFetchUser(uid: uid, fcmToken: fcmToken) { [weak self] snapshot, error in
            if let error = error {
                print("DEBUG - FetchUser Error: ", #function, error.localizedDescription)
            }
            guard let self = self,
                  let data = snapshot?.data() else { return }
            self.currentUser = User(uid: uid, dictionary: data)
            print("DEBUG - CurrentUser: \(String(describing: self.currentUser))")
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func didTapSignOutItem() {
        showAlert(message: "로그아웃 하시겠습니까?",
                  cancelButtonName: "취소",
                  confirmButtonName: "확인",
                  confirmButtonCompletion:  {
            do {
                // TODO: - 로그아웃 딥링크 로직 처리 확인 후 재설정
                AuthAPI.shared.updateFCMToken(uid: self.currentUser!.uid, fcmToken: "") { error in
                    print("DEBUG - Logout FCM update error", error?.localizedDescription as Any)
                }
                try Auth.auth().signOut()
                
                Messaging.messaging().deleteToken { error in
                    if let error = error {
                        print("DEBUG - deleteToken Error: \(error.localizedDescription)")
                    } else {
                        Messaging.messaging().token { token, _ in
                            if let token = token {
                                print("FCM 토큰", #function, token)
                                UserDefaults.standard.set(token, forKey: "FCMToken")
                            }
                        }
                    }
                }
            } catch {
                print("DEBUG - didTapSignOutItem Error: \(error.localizedDescription)")
            }
        })
    }
    
    @objc
    private func didTapAddItem() {
//        showAlert(title: "새로운 채널 생성",
//                  cancelButtonName: "취소",
//                  confirmButtonName: "확인",
//                  isExistsTextField: true, confirmButtonCompletion:  { [weak self] in
//            self?.channelAPI.createChannel(with: self?.alertController?.textFields?.first?.text ?? "")
//        })
    }
    
    @objc
    private func didTapFriend() {
        self.navigationController?.pushViewController(ChannelFriendView(), animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(channelTableView)
        channelTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func updateCell(to data: [(Channel, DocumentChangeType)]) {
        data.forEach { channel, documentChangeType in
            switch documentChangeType {
            case .added:
                addChannelToTable(channel)
            case .modified:
                updateChannelInTable(channel)
            case .removed:
                removeChannelFromTable(channel)
            }
        }
    }
    
    private func addToolBarItems() {
        toolbarItems = [
            UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(didTapSignOutItem)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "친구리스트", style: .plain, target: self, action: #selector(didTapFriend)),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddItem))
        ]
        navigationController?.isToolbarHidden = false
    }
    
    private func addChannelToTable(_ channel: Channel) {
        guard channels.contains(channel) == false else { return }
        
        channels.append(channel)
        channels.sort()
        
        guard let index = channels.firstIndex(of: channel) else { return }
        channelTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func updateChannelInTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else { return }
        channels[index] = channel
        channelTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func removeChannelFromTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else { return }
        channels.remove(at: index)
        channelTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
