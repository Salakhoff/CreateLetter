//
//  ViewController.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class LetterViewController: UIViewController {
    
    private lazy var letterTextView = LetterTextView()
    private lazy var textViewToolbar: UIToolbar = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        workWithNotificationCenter()
        configureInitialSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTextWithSettings()
    }
    
    @objc private func okButtonTapped() {
        let settingsManager = SettingsManager.shared
        var updateSettings = settingsManager.loadSettings()
        updateSettings.text = letterTextView.text
       
        settingsManager.saveSettings(updateSettings)
        letterTextView.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: SetupView
private extension LetterViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Письмо"
        
        view.addSubview(letterTextView)
        letterTextView.inputAccessoryView = textViewToolbar
        
        setupShareButton()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            letterTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            letterTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            letterTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            letterTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func updateTextWithSettings() {
        let settingsManager = SettingsManager.shared
        let savedSettings = settingsManager.loadSettings()
        
        let fontName = savedSettings.fontType.rawValue
        let fontSize = CGFloat(savedSettings.fontSize)
        
        var font: UIFont
        if savedSettings.fontThinkess == .bold {
            font = UIFont(descriptor: UIFontDescriptor(name: fontName, size: fontSize).withSymbolicTraits(.traitBold) ?? UIFontDescriptor(name: fontName, size: fontSize), size: fontSize)
        } else {
            font = UIFont(descriptor: UIFontDescriptor(name: fontName, size: fontSize), size: fontSize)
        }
        
        letterTextView.font = font
        letterTextView.textColor = savedSettings.fontColor.uiColor()
    }
    
    private func configureInitialSettings() {
        let settingsManager = SettingsManager.shared
        let initialSettings = settingsManager.loadSettings()
        letterTextView.text = initialSettings.text
    }
    
    private func setupShareButton() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func shareAction() {
        if let textToShare = letterTextView.text {
            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            self.present(activityViewController, animated: true)
        }
    }
}

// MARK: -NotificationCenter
extension LetterViewController {
    private func workWithNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.size.height
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            letterTextView.contentInset = contentInsets
            letterTextView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets.zero
        letterTextView.contentInset = contentInsets
        letterTextView.scrollIndicatorInsets = contentInsets
    }
}

