//
//  SettingsViewController.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let settingsFontSizeLabel = DescriptionLabel(labelText: "Размера шрифта:")
    private lazy var valueSliderLabel = DescriptionLabel(labelText: "0")
    private lazy var settingsFontSlider = FontSizeSlider()
    
    private let settingsFontLabel = DescriptionLabel(labelText: "Шрифт:")
    private lazy var fontTextField = SettingsTextField()
    
    private let settingsColorLabel = DescriptionLabel(labelText: "Цвет текста:")
    private lazy var colorTextField = SettingsTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
}

// MARK: -SetupView
private extension SettingsViewController {
    func setupView() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
        
        view.addSubview(settingsFontSizeLabel)
        view.addSubview(settingsFontSlider)
        view.addSubview(valueSliderLabel)
        
        view.addSubview(settingsFontLabel)
        view.addSubview(fontTextField)
        
        view.addSubview(settingsColorLabel)
        view.addSubview(colorTextField)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            settingsFontSizeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsFontSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsFontSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            valueSliderLabel.topAnchor.constraint(equalTo: settingsFontSizeLabel.bottomAnchor, constant: 10),
            valueSliderLabel.trailingAnchor.constraint(equalTo: settingsFontSizeLabel.trailingAnchor),
            valueSliderLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            settingsFontSlider.leadingAnchor.constraint(equalTo: settingsFontSizeLabel.leadingAnchor),
            settingsFontSlider.centerYAnchor.constraint(equalTo: valueSliderLabel.centerYAnchor),
            settingsFontSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            settingsFontLabel.topAnchor.constraint(equalTo: valueSliderLabel.bottomAnchor, constant: 20),
            settingsFontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsFontLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fontTextField.topAnchor.constraint(equalTo: settingsFontLabel.bottomAnchor, constant: 10),
            fontTextField.leadingAnchor.constraint(equalTo: settingsFontLabel.leadingAnchor),
            fontTextField.trailingAnchor.constraint(equalTo: settingsFontLabel.trailingAnchor),
            
            settingsColorLabel.topAnchor.constraint(equalTo: fontTextField.bottomAnchor, constant: 20),
            settingsColorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsColorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorTextField.topAnchor.constraint(equalTo: settingsColorLabel.bottomAnchor, constant: 10),
            colorTextField.leadingAnchor.constraint(equalTo: settingsColorLabel.leadingAnchor),
            colorTextField.trailingAnchor.constraint(equalTo: settingsColorLabel.trailingAnchor),
        ])
    }
}
