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

    func fetchWeather() {
        guard let url = URL(string: "https://data.api.xweather.com/observations/seattle,wa?client_id=\(clientId)&client_secret=\(clientSecret)")
        else {
            errorMessage = "Invalid URL Address"
            return
        }

        isLoading = true
        errorMessage = nil

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ModelWeather.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Weather fetch failed:", error)
                    self?.errorMessage = "Failed to load weather: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] model in
                if model.success, model.response != nil {
                    self?.weather = model
                } else {
                    self?.errorMessage = model.error?.description ?? "Unknown API error"
                }
            })
            .store(in: &cancellables)
    }
}
