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
    func showQuizzesController()
    func showQuizViewController()
}

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showQuizzesController() {
        let vc = QuizzesViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showQuizViewController() {
        let vc = QuizViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
