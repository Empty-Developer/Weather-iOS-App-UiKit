//
//  ViewModelOutfitOfTheDay.swift
//  Weather-App
//
//  Created by Valera on 16.09.2026.
//

import Foundation

class ViewModelOutfitOfTheDay {
    
    private let data: ModelDataOutfitOfTheDay
    
    init(data: ModelDataOutfitOfTheDay = ModelDataOutfitOfTheDay()) {
        self.data = data
    }
    
    func recommendation(for temperatureC: Int) -> String {
        let temperature = min(max(temperatureC, -40), 40)
        let roundedTemperature = Int(
            (Double(temperature) / 10.0).rounded() * 10
        )
        let key = String(roundedTemperature)
        return data.textInformation[key] ?? ""
    }
    
    
}
