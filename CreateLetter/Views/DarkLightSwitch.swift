//
//  DarkLightSwitch.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class DarkLightSwitch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DarkLightSwitch {
    private func setupSwitch() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
