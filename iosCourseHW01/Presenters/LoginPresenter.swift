//
//  LoginPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol LoginViewDelegate: NSObjectProtocol {
    func updateErrorLabel()
    func goToTabBarController()
}

class LoginPresenter {
    
    private let networkService: NetworkService
    weak private var loginViewDelegate: LoginViewDelegate?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setViewDelegate(loginViewDelegate: LoginViewDelegate?) {
        self.loginViewDelegate = loginViewDelegate
    }
    
    func login(username: String, password: String) {
        networkService.login(email: username, password: password) { loginStatus in
            if case LoginStatus.success = loginStatus {
                self.loginViewDelegate?.goToTabBarController()
            } else {
                self.loginViewDelegate?.updateErrorLabel()
            }
        }
    }
    
}
