//
//  DescriptionLabel.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class DescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    convenience init(labelText: String?) {
        self.init()
        guard let labelText else { return }
        self.text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionLabel {
    private func setupLabel() {
        font = .systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
