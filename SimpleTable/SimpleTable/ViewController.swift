//
//  ViewController.swift
//  SimpleTable
//
//  Created by 진태영 on 2023/03/31.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    
    let korean: [String] = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 코드로 작성할 경우
        /*
        self.tableView.delegate = self
        self.tableView.dataSource = self
         */
        
    }
    
    // 테이블뷰의 섹션 갯수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 테이블뷰의 섹션마다 행 개수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        default:
            return 0
        }
    }
    
    // 테이블뷰의 셀 내용 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        cell.textLabel?.text = text
        
        return cell
    }

    // 테이블뷰의 섹션 헤더 작성
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "한글" : "영어"
    }
}

