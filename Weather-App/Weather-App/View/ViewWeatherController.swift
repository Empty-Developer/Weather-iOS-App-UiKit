//
//  ViewController.swift
//  Weather-App
//
//  Created by Valera on 31.08.2026.
//

import UIKit
import Combine

enum ButtonVariation: String, CaseIterable {
    case miami = "MIAMI"
    case newyork = "NEW YORK"
    case tokyo = "TOKYO"
}

class ViewWeatherController: UIViewController {
    // MARK: - Dependencies
    private var viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = Set()
    private var cityVariantViews: [ButtonVariation: UIStackView] = [:]
    
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = WeatherViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - UI
    private func createButtonVarian(variant: ButtonVariation) -> UIView {
        let button = UIButton(type: .system)
        button.setTitle(variant.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.getGeistVaribleFont(fontType: .bold, size: 18)
        button.isUserInteractionEnabled = false
        
        let underlineView: UIView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        button.setTitleColor(.lightGray, for: .normal)
        underlineView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [button, underlineView])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.tag = variant.hashValue
        
        return stackView
    }
    
    private lazy var citySelectorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for variant in ButtonVariation.allCases {
            let view = createButtonVarian(variant: variant)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cityViewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
            
            if let stackView = view as? UIStackView {
                cityVariantViews[variant] = stackView
            }
            
            stack.addArrangedSubview(view)
        }
        
        return stack
    }()
    
    @objc private func cityViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        guard let selectedVariant = ButtonVariation.allCases.first(where: { $0.hashValue == tappedView.tag }) else { return }
        
        switch selectedVariant {
        case .miami:
            viewModel.selectCity(.miami)
        case .newyork:
            viewModel.selectCity(.newyork)
        case .tokyo:
            viewModel.selectCity(.tokyo)
        }
        
        updateSelectionUI(for: selectedVariant)
    }
    
    private func updateSelectionUI(for selectedVariant: ButtonVariation) {
        UIView.animate(withDuration: 0.25) {
            for (variant, stackView) in self.cityVariantViews {
                let button = stackView.arrangedSubviews[0] as? UIButton
                let underline = stackView.arrangedSubviews[1]
                
                let isSelected = (variant == selectedVariant)
                
                button?.setTitleColor(isSelected ? .black : .lightGray, for: .normal)
                underline.backgroundColor = isSelected ? .black : .lightGray
            }
        }
    }
    
    private func createLabel(text: String, frame: CGRect, font: UIFont) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.frame = frame
        label.font = font
        label.textColor = .black
        return label
    }
    
    lazy var degree: UILabel = createLabel(text: "—", frame: CGRect(x: 30, y: 180, width: view.frame.width - 70, height: 210), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 180))
    
    lazy var approximateTemperatureToday: UILabel = createLabel(text: "today —° - —°", frame: CGRect(x: 35, y: degree.frame.maxY + 20, width: view.frame.width - 70, height: 26), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 26))
    
    lazy var iconWeather: UIImageView = {
        $0.image = .loadingIcon
        $0.frame = CGRect(x: degree.frame.midX + 110, y: degree.frame.minY + -10, width: 35, height: 35)
        return $0
    }(UIImageView())
    
    lazy var descriptionInformation: UILabel = createLabel(text: "outfit of the day", frame: CGRect(x: 35, y: approximateTemperatureToday.frame.maxY + 140, width: view.frame.width - 70, height: 12), font: UIFont.getGeistVaribleFont(fontType: .medium, size: 12))
    
    lazy var informationOfDay: UILabel = {
        $0.text = "———, ———, ———, ———, ———"
        $0.numberOfLines = 0
        $0.font = UIFont.getGeistVaribleFont(fontType: .bold, size: 48)
        $0.textColor = .black
        $0.frame = CGRect(x: 35, y: descriptionInformation.frame.maxY + 10, width: view.frame.width - 70, height: 0)
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(citySelectorStackView)
        view.addSubview(degree)
        view.addSubview(approximateTemperatureToday)
        view.addSubview(iconWeather)
        view.addSubview(descriptionInformation)
        view.addSubview(informationOfDay)
        
        NSLayoutConstraint.activate([
            citySelectorStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            citySelectorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width - 325)
        ])
    }
    
    // MARK: - Bindin
    private func bindViewModel() {
        viewModel.$weatherIconName
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] iconWeather in
                self?.iconWeather.image = UIImage(named: iconWeather)
            }
            .store(in: &cancellables)
        
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
        updateSelectionUI(for: .miami)
    }
}

