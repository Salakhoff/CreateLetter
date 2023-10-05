//
//  SettingsTextField.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class SettingsTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTextFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsTextField {
    private func setupTextFields() {
        borderStyle = .roundedRect
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        isContextMenuInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}

