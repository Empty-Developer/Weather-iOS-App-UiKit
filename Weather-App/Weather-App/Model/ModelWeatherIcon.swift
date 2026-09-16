//
//  ModelWeatherIcon.swift
//  Weather
//
//  Created by Valera on 16.09.2026.
//

import Foundation
import UIKit

struct GalleryIcon: Identifiable {
    let id = UUID()
    let title: String
    let iconName: CGRect
    
    var image: UIImageView {
        UIImageView(frame: iconName)
    }
}
