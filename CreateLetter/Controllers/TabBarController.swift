//
//  TabBarController.swift
//  CreateLetter
//
//  Created by Ильфат Салахов on 02.10.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

extension TabBarController {
    private func setupTabBar() {
        let letterVC = LetterViewController()
        let settingsVC = SettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: letterVC)
        let nav2 = UINavigationController(rootViewController: settingsVC)
        
        let tintColor = UIColor.systemOrange
        let unselectedTintColor = UIColor.systemGray
        
        let textImage = UIImage(systemName: "text.aligncenter")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        let settingImage = UIImage(systemName: "gear")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        
        let textUnselectedImage = textImage?.withTintColor(unselectedTintColor, renderingMode: .alwaysOriginal)
        let settinghUnselectedImage = settingImage?.withTintColor(unselectedTintColor, renderingMode: .alwaysOriginal)
        
        nav1.tabBarItem = UITabBarItem(title: "Письмо", image: textUnselectedImage, selectedImage: textImage)
        nav2.tabBarItem = UITabBarItem(title: "Настройки", image: settinghUnselectedImage, selectedImage: settingImage)
        
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: unselectedTintColor]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: tintColor]
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
            
            nav.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
            nav.tabBarItem.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        }
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
