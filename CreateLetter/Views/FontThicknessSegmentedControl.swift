//
//  FontThickness.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class FontThicknessSegmentedControl: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FontThicknessSegmentedControl {
    private func setupSegmentedControl() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
