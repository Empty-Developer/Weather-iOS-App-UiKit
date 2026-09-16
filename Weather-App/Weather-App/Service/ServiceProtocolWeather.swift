//
//  ServiceProtocolWeather.swift
//  Weather-App
//
//  Created by Valera on 16.09.2026.
//

import Foundation
import Combine

protocol ServiceProtocolWeather {
    func fetchWeather() -> AnyPublisher<ModelWeather, Error>
}
