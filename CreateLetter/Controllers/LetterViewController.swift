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
}

