//
//  ViewController.swift
//  Weather-App
//
//  Created by Valera on 31.08.2026.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    /*
        TODO:
        2) layout
        3) button
        5) icon move
        9) 3 screen (1 London, 2 New Yourk, 3 Moscov)
     */
    private let viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = Set()
    
    func createLabel(text: String, frame: CGRect, font: UIFont) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.frame = frame
        label.font = font
        label.textColor = .black
        return label
    }
    
    lazy var btnAction: UIAction = UIAction { [weak self] _ in
        self?.viewModel.fetchWeather()
        
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
        $0.text = "———, ———, ———, ———, ———"
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
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(degree)
        view.addSubview(approximateTemperatureToday)
        view.addSubview(iconWeather)
        view.addSubview(descriptionInformation)
        view.addSubview(informationOfDay)
        view.addSubview(getWeatherbtn)
    }
    
    private func bindViewModel() {
        viewModel.$weather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let self = self, let ob = weather?.response?.ob else { return }
                
                if let tempC = ob.tempC {
                    self.degree.text = "\(Int(tempC))"
                    
                    let userInfo = ViewModelOutfitOfTheDay(dataUser: Int(tempC))
                    self.informationOfDay.text = userInfo.getValyeOutfit()
                }
                
                if let minTempC = ob.dewpointC,
                   let maxTempC = ob.tempC {
                    self.approximateTemperatureToday.text = "today \(minTempC)° - \(maxTempC)°"
                }
                
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.getWeatherbtn.isEnabled = !isLoading
                self?.getWeatherbtn.alpha = isLoading ? 0.5 : 1.0
            }
            .store(in: &cancellables)
                
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }
        
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
}
