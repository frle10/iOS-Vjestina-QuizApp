//
//  AppRouter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 06.05.2021..
//
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window: UIWindow?)
    
    func showLoginController()
    func showTabBarController()
    func showQuizzesController()
    func showQuizController(quiz: Quiz)
    func showQuizResultController(pageController: QuizPageViewController)
}

class AppRouter: AppRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)
        navigationController.pushViewController(vc, animated: false)
        navigationController.isNavigationBarHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showLoginController() {
        let vc = LoginViewController(router: self)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func showTabBarController() {
        let tabBarController = CustomTabBarController(router: self)
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    func showQuizzesController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showQuizController(quiz: Quiz) {
        let vc = QuizPageViewController(router: self, quiz: quiz)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showQuizResultController(pageController: QuizPageViewController) {
        let vc = QuizResultViewController(router: self, pageController: pageController)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
