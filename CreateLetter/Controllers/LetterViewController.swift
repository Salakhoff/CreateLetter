//
//  ViewController.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class LetterViewController: UIViewController {
    
    private lazy var letterTextView = LetterTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        workWithNotificationCenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTextWithSettings()
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
}

//MARK: -NotificationCenter
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

