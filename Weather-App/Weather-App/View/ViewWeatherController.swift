//
//  ViewController.swift
//  Weather-App
//
//  Created by Valera on 31.08.2026.
//

import UIKit
import Combine

/*
    TODO: Work
    2. configure ModelIcon
    2. configure ProviderIcon
    2. configure ViewModelIcon
 
    3. create three button London, Moscow, Tokyo
    3. configure ViewModelWeather for three location
 
    4. configure media
*/

class ViewWeatherController: UIViewController {
    // MARK: - Dependencies
    private var viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = Set()
    
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = WeatherViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - UI
    
    private func createLabel(text: String, frame: CGRect, font: UIFont) -> UILabel {
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
    
    lazy var descriptionInformation: UILabel = createLabel(text: "outfit of the day", frame: CGRect(x: 35, y: approximateTemperatureToday.frame.maxY + 180, width: view.frame.width - 70, height: 12), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 12))
    
    lazy var informationOfDay: UILabel = {
        $0.text = "———, ———, ———, ———, ———"
        $0.numberOfLines = 0
        $0.font = UIFont.getGeistVaribleFont(fontType: .bold, size: 48)
        $0.textColor = .black
        $0.frame = CGRect(x: 35, y: descriptionInformation.frame.maxY + 20, width: view.frame.width - 70, height: 0)
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(degree)
        view.addSubview(approximateTemperatureToday)
        view.addSubview(iconWeather)
        view.addSubview(descriptionInformation)
        view.addSubview(informationOfDay)
    }
    
    // MARK: - Bindin
    private func bindViewModel() {
            viewModel.$temperatureText
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    self?.degree.text = text
                }
                .store(in: &cancellables)
     
            viewModel.$temperatureRangeText
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    self?.approximateTemperatureToday.text = text
                }
                .store(in: &cancellables)
     
            viewModel.$outfitText
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    self?.informationOfDay.text = text
                }
                .store(in: &cancellables)
     
            viewModel.$isLoading
                .receive(on: DispatchQueue.main)
                .sink { [weak self] isLoading in
                    self?.view.alpha = isLoading ? 0.5 : 1.0
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
        viewModel.fetchWeather()
    }
    
}
