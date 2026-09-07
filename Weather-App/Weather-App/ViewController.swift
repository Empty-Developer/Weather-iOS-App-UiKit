//
//  ViewController.swift
//  Weather-App
//
//  Created by Valera on 31.08.2026.
//

import UIKit

class ViewController: UIViewController {

    let degree: UILabel = UILabel()
    let approximateTemperatureToday: UILabel = UILabel()
    let iconWeather: UIImageView = UIImageView()
    
    let descriptionInformation: UILabel = UILabel()
    let informationOfDay: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        degree.text = "27"
        degree.font = UIFont.systemFont(ofSize: 210, weight: .medium)
        degree.textColor = .black
        degree.frame = CGRect(x: 35, y: 180, width: view.frame.width - 70, height: 210)
        
        approximateTemperatureToday.text = "today 18° - 27°"
        approximateTemperatureToday.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        approximateTemperatureToday.textColor = .black
        approximateTemperatureToday.frame = CGRect(x: 35, y: degree.frame.maxY + 20, width: view.frame.width - 70, height: 26)
        
        iconWeather.image = .sunIcon
        iconWeather.frame = CGRect(x: degree.frame.midX + 100, y: degree.frame.minY + 35, width: 40, height: 40)
        
        descriptionInformation.text = "outfit of the day"
        descriptionInformation.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        descriptionInformation.textColor = .black
        descriptionInformation.frame = CGRect(x: 35, y: approximateTemperatureToday.frame.maxY + 198, width: view.frame.width - 70, height: 12)
        
        informationOfDay.text = "shirt, pants, jeans, dress, skirt"
        informationOfDay.numberOfLines = 0
        informationOfDay.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        informationOfDay.textColor = .black
        informationOfDay.frame = CGRect(x: 35, y: descriptionInformation.frame.maxY + 20, width: view.frame.width - 70, height: 0)
        informationOfDay.sizeToFit()
        
        view.addSubview(degree)
        view.addSubview(approximateTemperatureToday)
        view.addSubview(iconWeather)
        view.addSubview(descriptionInformation)
        view.addSubview(informationOfDay)
        
    }
    
}

