//
//  SettingsViewController.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: -UIOutlets
    private let settingsFontSizeLabel = DescriptionLabel(labelText: "Изменение размера шрифта:")
    private lazy var valueSliderLabel = DescriptionLabel()
    private lazy var settingsFontSlider = FontSizeSlider()
    
    private let settingsColorLabel = DescriptionLabel(labelText: "Изменение цвета букв")
    private lazy var colorTextField = SettingsTextField()
    
    private let settingsFontThicknessLabel = DescriptionLabel(labelText: "Регулировка толщины шрифта")
    
    private lazy var fontThicknessSegmentedControl: FontThicknessSegmentedControl = {
        let items = FontThicknessText.allCases.map { $0.rawValue }
        let segmentedControl = FontThicknessSegmentedControl(items: items)
        return segmentedControl
    }()
    
    private let settingsFontLabel = DescriptionLabel(labelText: "Выбор шрифта")
    private lazy var fontTextField = SettingsTextField()
    
    private let settingsDarkLightLabel = DescriptionLabel(labelText: "Ночной режим")
    private lazy var settingsDarkLightSwitch = DarkLightSwitch()
    
    private lazy var colorPickerView = UIPickerView()
    private lazy var fontPickerView = UIPickerView()
    
    private lazy var textFieldToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(okButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, cancelButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setDelegate()
        addTarget()
        configureInitialSettings()
        setupTextFields()
    }
    
    private func setDelegate() {
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        fontPickerView.delegate = self
        fontPickerView.dataSource = self
    }
    
    private func addTarget() {
        settingsFontSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged), for: .valueChanged)
        settingsDarkLightSwitch.addTarget(self, action: #selector(darkLightSwitchValueChanged), for: .valueChanged)
        fontThicknessSegmentedControl.addTarget(self, action: #selector(fontThicknessSegmentedValueChanged), for: .valueChanged)
    }
    
    // MARK: -Actions
    @objc private func okButtonTapped() {
        let settingsManager = SettingsManager.shared
        var updateSettings = settingsManager.loadSettings()
        
        if colorTextField.isEditing {
            if let selectColorText = colorTextField.text,
               let selectColor = ColorText(rawValue: selectColorText) {
                updateSettings.fontColor = selectColor
            }
            settingsManager.saveSettings(updateSettings)
            colorTextField.resignFirstResponder()
        }
        
        if fontTextField.isEditing {
            if let selectFontText = fontTextField.text,
               let selectFont = FontTypeText(rawValue: selectFontText) {
                updateSettings.fontType = selectFont
            }
            settingsManager.saveSettings(updateSettings)
            fontTextField.resignFirstResponder()
        }
    }
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        valueSliderLabel.text = "\(Int(sender.value))"
        
        let settingsManager = SettingsManager.shared
        var updateSettings = settingsManager.loadSettings()
        updateSettings.fontSize = sender.value
        
        settingsManager.saveSettings(updateSettings)
    }
    
    @objc private func darkLightSwitchValueChanged() {
        let settingsManager = SettingsManager.shared
        var updateSettings = settingsManager.loadSettings()
        updateSettings.nightModeEnabled = settingsDarkLightSwitch.isOn
        
        settingsManager.saveSettings(updateSettings)
        
        updateAppearanceForNightMode(enable: settingsDarkLightSwitch.isOn)
    }
    
    @objc func fontThicknessSegmentedValueChanged(_ sender: UISegmentedControl) {
        let settingsManager = SettingsManager.shared
        var updateSettings = settingsManager.loadSettings()
        
        let selectedIndex = sender.selectedSegmentIndex
        let arrayFontThicknessText = FontThicknessText.allCases
        if let selectedThickness = FontThicknessText(rawValue: arrayFontThicknessText[selectedIndex].rawValue) {
            updateSettings.fontThinkess = selectedThickness
        }
        
        settingsManager.saveSettings(updateSettings)
    }
    
    private func updateAppearanceForNightMode(enable: Bool) {
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionCrossDissolve) {
            if enable {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            } else {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
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
        
        view.addSubview(settingsColorLabel)
        view.addSubview(colorTextField)
        
        view.addSubview(settingsFontThicknessLabel)
        view.addSubview(fontThicknessSegmentedControl)
        
        view.addSubview(settingsFontLabel)
        view.addSubview(fontTextField)
        
        view.addSubview(settingsDarkLightLabel)
        view.addSubview(settingsDarkLightSwitch)
        
        colorTextField.inputView = colorPickerView
        colorTextField.inputAccessoryView = textFieldToolbar
        
        fontTextField.inputView = fontPickerView
        fontTextField.inputAccessoryView = textFieldToolbar
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // SettingFontSize
            settingsFontSizeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsFontSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsFontSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            valueSliderLabel.topAnchor.constraint(equalTo: settingsFontSizeLabel.bottomAnchor, constant: 10),
            valueSliderLabel.trailingAnchor.constraint(equalTo: settingsFontSizeLabel.trailingAnchor),
            valueSliderLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            settingsFontSlider.leadingAnchor.constraint(equalTo: settingsFontSizeLabel.leadingAnchor),
            settingsFontSlider.centerYAnchor.constraint(equalTo: valueSliderLabel.centerYAnchor),
            settingsFontSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            // SettingColorLabel
            settingsColorLabel.topAnchor.constraint(equalTo: settingsFontSlider.bottomAnchor, constant: 20),
            settingsColorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsColorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorTextField.topAnchor.constraint(equalTo: settingsColorLabel.bottomAnchor, constant: 10),
            colorTextField.leadingAnchor.constraint(equalTo: settingsColorLabel.leadingAnchor),
            colorTextField.trailingAnchor.constraint(equalTo: settingsColorLabel.trailingAnchor),
            
            
            // SettingFontThickness
            settingsFontThicknessLabel.topAnchor.constraint(equalTo: colorTextField.bottomAnchor, constant: 20),
            settingsFontThicknessLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsFontThicknessLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fontThicknessSegmentedControl.topAnchor.constraint(equalTo: settingsFontThicknessLabel.bottomAnchor, constant: 10),
            fontThicknessSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fontThicknessSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // SettingFont
            settingsFontLabel.topAnchor.constraint(equalTo: fontThicknessSegmentedControl.bottomAnchor, constant: 20),
            settingsFontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsFontLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fontTextField.topAnchor.constraint(equalTo: settingsFontLabel.bottomAnchor, constant: 10),
            fontTextField.leadingAnchor.constraint(equalTo: settingsFontLabel.leadingAnchor),
            fontTextField.trailingAnchor.constraint(equalTo: settingsFontLabel.trailingAnchor),
            
            // SettingDarkLight
            settingsDarkLightLabel.topAnchor.constraint(equalTo: fontTextField.bottomAnchor, constant: 20),
            settingsDarkLightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            settingsDarkLightSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsDarkLightSwitch.centerYAnchor.constraint(equalTo: settingsDarkLightLabel.centerYAnchor),
        ])
        
        
    }
    private func setupTextFields() {
        let settingsManager = SettingsManager.shared
        var currentColor = settingsManager.loadSettings()
        
        
        if let currentColorText = ColorText(rawValue: currentColor.fontColor.rawValue) {
            if let row = ColorText.allCases.firstIndex(of: currentColorText) {
                colorPickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
        
        if let currentFontTypeText = FontTypeText(rawValue: currentColor.fontType.rawValue) {
            if let row = FontTypeText.allCases.firstIndex(of: currentFontTypeText) {
                fontPickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    
    private func configureInitialSettings() {
        let settingsManager = SettingsManager.shared
        let initialSettings = settingsManager.loadSettings()
        
        settingsFontSlider.value = initialSettings.fontSize
        valueSliderLabel.text = "\(Int(initialSettings.fontSize))"
        colorTextField.text = initialSettings.fontColor.rawValue
        fontThicknessSegmentedControl.selectedSegmentIndex = initialSettings.fontThinkess.rawValue == FontThicknessText.normal.rawValue ? 0 : 1
        fontTextField.text = initialSettings.fontType.rawValue
        settingsDarkLightSwitch.isOn = initialSettings.nightModeEnabled
    }
}



// MARK: -UIPickerViewDataSource
extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case colorPickerView: ColorText.allCases.count
        case fontPickerView: FontTypeText.allCases.count
        default: 0
        }
    }
}

// MARK: - UIPickerViewDelegate
extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case colorPickerView: ColorText.allCases[row].rawValue
        case fontPickerView: FontTypeText.allCases[row].rawValue
        default: ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case colorPickerView: self.colorTextField.text = ColorText.allCases[row].rawValue
        case fontPickerView: self.fontTextField.text = FontTypeText.allCases[row].rawValue
        default: break
        }
    }
}
