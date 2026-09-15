//
//  ViewModelOutfitOfTheDay.swift
//  Weather-App
//
//  Created by Valera on 16.09.2026.
//

import Foundation

class ViewModelOutfitOfTheDay {
    
    var textOutfitOfTheDay = ModelDataOutfitOfTheDay()
    var dataUser: Int
    
    func getValyeOutfit() -> String {
        let temperature = min(max(dataUser, -40), 40)
        
        let roundedTemperature = Int(
            (Double(temperature) / 10.0).rounded() * 10
        )
        
        let key = String(roundedTemperature)
        
        return textOutfitOfTheDay.textInformation[key] ?? ""
    }
    
    init(textOutfitOfTheDay: ModelDataOutfitOfTheDay = ModelDataOutfitOfTheDay(), dataUser: Int) {
        self.textOutfitOfTheDay = textOutfitOfTheDay
        self.dataUser = dataUser
    }
}
