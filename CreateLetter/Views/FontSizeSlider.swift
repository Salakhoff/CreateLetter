//
//  FontSizeSlider.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class FontSizeSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FontSizeSlider {
    private func setupSlider() {
        minimumValue = 1
        maximumValue = 100
        translatesAutoresizingMaskIntoConstraints = false
    }
}
