//
//  ServiceWeather.swift
//  Weather-App
//
//  Created by Valera on 16.09.2026.
//

import Foundation
import Combine
 
enum ServiceWeatherError: LocalizedError {
    case invalidURL
    case apiError(String)
 
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL Address"
        case .apiError(let message):
            return message
        }
    }
}
 
final class WeatherService: ServiceProtocolWeather {
 
    private let session: URLSession
    private let decoder: JSONDecoder
 
    init(session: URLSession = .shared) {
        self.session = session
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }
 
    func fetchWeather() -> AnyPublisher<ModelWeather, Error> {
        guard let url = URL(
            string: "https://data.api.xweather.com/observations/seattle,wa?client_id=V6RJhXJfqG7uLStG5TFuF&client_secret=E9pC7YD6KVJZPN4dPpuSPJ04FgvqfW0tda62A4Qq"
        ) else {
            return Fail(error: ServiceWeatherError.invalidURL).eraseToAnyPublisher()
        }
 
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ModelWeather.self, decoder: decoder)
            .tryMap { model in
                guard model.success, model.response != nil else {
                    throw ServiceWeatherError.apiError(model.error?.description ?? "Unknown API error")
                }
                return model
            }
            .eraseToAnyPublisher()
    }
}
