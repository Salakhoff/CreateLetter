//
//  LetterTextView.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

final class LetterTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LetterTextView {
    private func setupTextView() {
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
}
