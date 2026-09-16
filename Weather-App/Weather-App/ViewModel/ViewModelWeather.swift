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
    @Publisher private(set) var temperatureText: String = "—"
    @Publisher private(set) var temperatureRangeText: String = "today —° - —°"
    @Publisher private(set) var outfitText: String = "———, ———, ———, ———, ———"
    @Publisher private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: Dependencies
    private let service: ServiceProtocolWeather
    private let outfitAdvisor: ViewModelOutfitOfTheDay
    private let location: String
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ServiceProtocolWeather = WeatherService(),
         outfitAdvisor: ViewModelOutfitOfTheDay = ViewModelOutfitOfTheDay(),
         location: String = "seattle,wa") {
        
        self.service = service
        self.outfitAdvisor = outfitAdvisor
        self.location = location
    }
    
    // MARK: - Private
    private func apply(_ model: ModelWeather) {
        guard let ob = model.response?.ob, let tempC = ob.tempC else { return }
     
        temperatureText = "\(Int(tempC))"
        outfitText = outfitAdvisor.recommendation(for: Int(tempC))
     
        if let dewpointC = ob.dewpointC {
            temperatureRangeText = "today \(dewpointC)° - \(tempC)°"
        }
    }
    
    func fetchWeather() {
        isLoading = true
        errorMessage = nil
    
        service.fetchWeather(for: location)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] model in
                self?.apply(model)
            })
            .store(in: &cancellables)
    }

}
