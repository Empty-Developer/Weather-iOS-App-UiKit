//
//  ReadAPIKey.swift
//  Weather-App
//
//  Created by Valera on 15.09.2026.
//

import Foundation

enum Secrets {
    static var clientId: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "WeatherClientID") as? String else {
            fatalError("WeatherClientID not found in info.plist")
        }
        return id
    }
    
    static var clientSecret: String {
        guard let secret = Bundle.main.object(forInfoDictionaryKey: "WeatherClientSecret") as? String else {
            fatalError("WeatherClientSecret not found in info.plist")
        }
        return secret
    }
}
