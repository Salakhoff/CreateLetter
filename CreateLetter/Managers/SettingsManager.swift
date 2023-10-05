//
//  SettingsManager.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 04.10.2023.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    private let userDefaults = UserDefaults.standard
    
    private init() {
        setDefaultSettings()
    }
    
    func setDefaultSettings() {
        userDefaults.register(defaults: [
            "fontSize": 16.0,
            "fontColor": ColorText.black.rawValue,
            "fontWeight": FontThicknessText.normal.rawValue,
            "fontName": FontTypeText.helvetica.rawValue,
            "nightModeEnabled": false,
            "text": ""
        ])
    }
    
    func saveSettings(_ settings: AppSettingsText) {
        userDefaults.set(settings.fontSize, forKey: "fontSize")
        userDefaults.set(settings.fontColor.rawValue, forKey: "fontColor")
        userDefaults.set(settings.fontThinkess.rawValue, forKey: "fontWeight")
        userDefaults.set(settings.fontType.rawValue, forKey: "fontName")
        userDefaults.set(settings.nightModeEnabled, forKey: "nightModeEnabled")
        userDefaults.set(settings.text, forKey: "text")
        userDefaults.synchronize()
    }
    
    func loadSettings() -> AppSettingsText {
        let fontSize = userDefaults.float(forKey: "fontSize")
        let fontColorRawValue = userDefaults.string(forKey: "fontColor") ?? ColorText.black.rawValue
        let fontThicknessRawValue = userDefaults.string(forKey: "fontWeight") ?? FontThicknessText.normal.rawValue
        let fontNameRawValue = userDefaults.string(forKey: "fontName") ?? FontTypeText.helvetica.rawValue
        let nightModeEnabled = userDefaults.bool(forKey: "nightModeEnabled")
        let text = userDefaults.string(forKey: "text") ?? ""
        
        let fontColor = ColorText(rawValue: fontColorRawValue) ?? .black
        let fontThickness = FontThicknessText(rawValue: fontThicknessRawValue) ?? .normal
        let fontName = FontTypeText(rawValue: fontNameRawValue) ?? .helvetica
        
        return AppSettingsText(
            fontSize: fontSize,
            fontThinkess: fontThickness,
            fontColor: fontColor,
            fontType: fontName,
            nightModeEnabled: nightModeEnabled,
            text: text
        )
    }
}
