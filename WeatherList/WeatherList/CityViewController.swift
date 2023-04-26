//
//  CityViewController.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as? CityTableViewCell ?? CityTableViewCell()
        
        cell.cityName.text = city[indexPath.row].cityName
        switch city[indexPath.row].state {
        case 10:
            cell.weatherImage.image = UIImage(named: "sunny")
        case 11:
            cell.weatherImage.image = UIImage(named: "cloudy")
        case 12:
            cell.weatherImage.image = UIImage(named: "rainy")
        case 13:
            cell.weatherImage.image = UIImage(named: "snowy")
        default:
            print("weather image error")
        }
        
        let c: Double = city[indexPath.row].celsius
        
        if c < 10 {
            cell.tempLabel.textColor = UIColor.blue
        } else {
            cell.tempLabel.textColor = UIColor.black
        }
        
        let f = c * 1.8 + 32
        let format: String = String.init(format: "%.1f", f)
        cell.tempLabel.text = "섭씨 \(c)도 / 화씨 \(format)도"
        
        let rain: Int = city[indexPath.row].rainfall
        cell.rainLabel.text = "강수 확률 \(rain)"
        
        if rain > 50 {
            cell.rainLabel.textColor = UIColor.orange
        } else {
            cell.rainLabel.textColor = UIColor.black
        }
        
        return cell
    }
    

    var country: String?
    var countryEg: String?
    
    var city: [CityPModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("새 view의 properties: \(self.country), \(self.countryEg)")
        self.navigationController?.navigationItem.title = country
        
        let jsonDecoder = JSONDecoder()
        
        guard let jsonAsset: NSDataAsset = NSDataAsset(name: "\(countryEg!)") else { return }
        
        do {
            let result = try jsonDecoder.decode([City].self, from: jsonAsset.data)
            self.city = result.map({ city in
                return CityPModel.converTo(city)
            })
        } catch {
            print("city json error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("run prepare")
        if segue.identifier == "detail" {
            print("city")
            guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else {
                return
            }
            
            guard let cell: CityTableViewCell = sender as? CityTableViewCell else { return }
            print("cell: \(cell)")
            print("cell.cityName: \(cell.cityName.text)")
            nextViewController.city = cell.cityName.text
            
            nextViewController.rainLabel = cell.rainLabel
            nextViewController.tempLabel = cell.tempLabel
            nextViewController.weatherImage = cell.weatherImage
//

            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
