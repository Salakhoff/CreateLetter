//
//  TextColor.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 03.10.2023.
//

import UIKit

enum ColorText: String, CaseIterable {
    case black = "Чёрный"
    case red = "Красный"
    case yellow = "Жёлтый"
    case green = "Зелёный"
    case white = "Белый"
    
    func uiColor() -> UIColor {
        switch self {
        case .black: return .black
        case .red: return .red
        case .yellow: return .yellow
        case .green: return .green
        case .white: return .white
        }
    }
}
