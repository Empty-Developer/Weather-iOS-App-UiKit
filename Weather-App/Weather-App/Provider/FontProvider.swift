//
//  FontProvider.swift
//  Weather-App
//
//  Created by Valera on 14.09.2026.
//

import UIKit
import Foundation

extension UIFont {
    static func getGeistVaribleFont(fontType: NoteType = .medium, size: CGFloat = 16) -> UIFont {
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
