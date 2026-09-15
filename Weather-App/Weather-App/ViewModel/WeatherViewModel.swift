//
//  WeatherViewModel.swift
//  Weather-App
//
//  Created by Valera on 13.09.2026.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: ModelWeather?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let clientId = Secrets.clientId
    private let clientSecret = Secrets.clientSecret
    
    func fetchWeather(for sity: String) {
        guard let url = URL(string: "https://data.api.xweather.com/observations/seattle,wa?client_id=\(clientId)&client_secret=\(clientSecret)")
        else {
            errorMessage = "Invalid URL Addres"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ModelWeather.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: {weather in
                self.weather = weather
            })
            .store(in: &self.cancellables)
    }
    
}
