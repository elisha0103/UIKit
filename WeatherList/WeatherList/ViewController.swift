//
//  ViewController.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as? CountryTableViewCell ?? CountryTableViewCell()
        let countryName: String = country[indexPath.row].koreanName
        let imageName: String = country[indexPath.row].assetName
        cell.defaultContentConfiguration().image
        cell.countryLabel.text = countryName
        cell.countryImg.image = UIImage(named: "flag_\(imageName)")
        
        return cell
    }
    

    var country: [CountryPModel] = []
    
    func change(s: String) -> String {
        
        switch s {
        case "한국":
            return "kr"
        case "독일":
            return "de"
        case "이탈리아":
            return "it"
        case "미국":
            return "us"
        case "프랑스":
            return "fr"
        case "일본":
            return "jp"
        default:
            return ""
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let countryAsset: NSDataAsset = NSDataAsset(name: "countries") else { return }
        
        do {
            let countryArr = try jsonDecoder.decode([Country].self, from: countryAsset.data)
            
            self.country = countryArr.map({ country in
                return CountryPModel.convertTo(country)
            })
                        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    


}

