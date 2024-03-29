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
    let customCellIdentifier: String = "customCell"
    
    let korean: [String] = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var dates: [Date] = []
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        
        return formatter
    }()

    
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        dates.append(Date())
        
        // self.tableView.reloadData()
        
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }

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
        return 3
    }
    
    // 테이블뷰의 섹션마다 행 개수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    // 테이블뷰의 셀 내용 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 2 {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)     // 지정된 재사용 식별자에 대한 재사용 가능한 테이블 뷰 셀 객체를 반환하고 테이블에 추가합니다.
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            
            // 셀의 재사용 확인하는 코드
            /*
            if indexPath.row == 1 {
                cell.backgroundColor = .red
            }
             */
            
            return cell
        } else {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
            
            cell.leftLabel?.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel?.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
        
        
    }

    // 테이블뷰의 섹션 헤더 작성
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        }
        return " "
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        nextViewController.textToSet = cell.textLabel?.text
        
        // nextViewController.textLabel.text = cell.textLabel?.text
        /*
         nextViewController UIComponent에 바로 전달하는 것이 불가능한 이유
         이 함수는 prepare 말 그대로 준비하는 단계이다.
         인스턴스는 생성되어있지만, 안에 있는 UI 구성 요소는 메모리 대기열에 올라가있지 않기 때문에 접근할 때 문제가 생기는 것이다.
         */
    }

}

