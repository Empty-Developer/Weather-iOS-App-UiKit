//
//  WeatherViewModel.swift
//  Weather-App
//
//  Created by Valera on 13.09.2026.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    // MARK: Published
    @Published private(set) var weatherIconName: String = "loading-icon"
    @Published private(set) var temperatureText: String = "—"
    @Published private(set) var temperatureRangeText: String = "today —° - —°"
    @Published private(set) var outfitText: String = "———, ———, ———, ———, ———"
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published private(set) var selectedCity: City = .miami
    // MARK: Dependencies
    private let service: ServiceProtocolWeather
    private let outfitAdvisor: ViewModelOutfitOfTheDay
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ServiceProtocolWeather = WeatherService(),
         outfitAdvisor: ViewModelOutfitOfTheDay = ViewModelOutfitOfTheDay()) {
        
        self.service = service
        self.outfitAdvisor = outfitAdvisor
        fetchWeather(for: selectedCity)
    }
    
    func selectCity(_ city: City) {
        self.selectedCity = city
        fetchWeather(for: city)
    }
    
    // MARK: - Private
    private func apply(_ model: ModelWeather) {
        guard let ob = model.response?.ob, let tempC = ob.tempC else { return }
     
        temperatureText = "\(Int(tempC))"
        outfitText = outfitAdvisor.recommendation(for: Int(tempC))
     
        if let dewpointC = ob.dewpointC {
            temperatureRangeText = "today \(Int(dewpointC - 3))° - \(Int(tempC + 3))°"
        }
        
        if let icon = ob.icon {
            weatherIconName = weatherAssetName(for: icon)
        }
        
    }
    
    func fetchWeather(for city: City) {
        isLoading = true
        errorMessage = nil
        
        service.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] model in
                self?.apply(model)
            })
            .store(in: &cancellables)
    }

}
