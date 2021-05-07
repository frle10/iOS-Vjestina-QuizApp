//
//  CustomTabBarViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
        
        let quizzesController = QuizzesViewController(router: router)
        let settingsController = SettingsViewController(router: router)
        
        viewControllers = [quizzesController, settingsController]
        tabBar.backgroundColor = .white
        
        quizzesController.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quiz"), selectedImage: UIImage(named: "quiz-selected"))
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settings-selected"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = 0
    }
    
}
