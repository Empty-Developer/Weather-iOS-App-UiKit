//
//  ViewController.swift
//  Weather-App
//
//  Created by Valera on 31.08.2026.
//

import UIKit

class ViewController: UIViewController {
    
    /*
        TODO:
        2) layout
        3) button
        4) weather api
        5) icon move
        6) array text
        7) today weather function
        8) MVVM
        9) 3 screen (1 London, 2 New Yourk, 3 Moscov)
     */
    
    
    func createLabel(text: String, frame: CGRect, font: UIFont) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.frame = frame
        label.font = font
        label.textColor = .black
        return label
    }
    
    lazy var btnAction: UIAction = UIAction { _ in
        self.degree.text = "27"
        self.approximateTemperatureToday.text = "today 17° - 23°"
        
    }
    
    lazy var degree: UILabel = createLabel(text: "—", frame: CGRect(x: 30, y: 180, width: view.frame.width - 70, height: 210), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 210))
    
    lazy var approximateTemperatureToday: UILabel = createLabel(text: "today —° - —°", frame: CGRect(x: 35, y: degree.frame.maxY + 20, width: view.frame.width - 70, height: 26), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 26))
    
    lazy var iconWeather: UIImageView = {
        $0.image = .sunIcon
        $0.frame = CGRect(x: degree.frame.midX + 90, y: degree.frame.minY + 35, width: 40, height: 40)
        return $0
    }(UIImageView())
    
    lazy var descriptionInformation: UILabel = createLabel(text: "outfit of the day", frame: CGRect(x: 35, y: approximateTemperatureToday.frame.maxY + 100, width: view.frame.width - 70, height: 12), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 12))
    
    lazy var informationOfDay: UILabel = {
        $0.text = "shirt, pants, jeans, dress, skirt"
        $0.numberOfLines = 0
        $0.font = UIFont.getGeistVaribleFont(fontType: .bold, size: 48)
        $0.textColor = .black
        $0.frame = CGRect(x: 35, y: descriptionInformation.frame.maxY + 20, width: view.frame.width - 70, height: 0)
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    lazy var getWeatherbtn: UIButton = {
        $0.setTitle("Get Weather", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 10
        $0.frame.size = CGSize(width: view.frame.width - 70, height: 50)
        $0.frame.origin = CGPoint(x: 30, y: informationOfDay.frame.maxY + 20)
        return $0
    }(UIButton(primaryAction: btnAction))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(degree)
        view.addSubview(approximateTemperatureToday)
        view.addSubview(iconWeather)
        view.addSubview(descriptionInformation)
        view.addSubview(informationOfDay)
        view.addSubview(getWeatherbtn)
        
    }
    
}

