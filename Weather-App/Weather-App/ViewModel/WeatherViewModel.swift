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
    
    private let clientId = "V6RJhXJfqG7uLStG5TFuF"
    private let clientSecret = "E9pC7YD6KVJZPN4dPpuSPJ04FgvqfW0tda62A4Qq"
    
    func fetchWeather(for sity: String) {
        guard let url = URL(string: "https://data.api.xweather.com/observations/seattle,wa?client_id=\(clientId)&client_secret=\(clientSecret)")
        else {
            errorMessage = "Invalid URL Addres"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        
    }
    
}
