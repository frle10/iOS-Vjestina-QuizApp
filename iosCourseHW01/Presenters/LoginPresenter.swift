//
//  LoginPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation
import Network

protocol LoginViewDelegate: NSObjectProtocol {
    func updateErrorLabel(text: String)
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
        let netConnection = NetMonitor.shared
        let status = netConnection.netOn
        
        if status {
            networkService.login(email: username, password: password) { loginStatus in
                if case LoginStatus.success = loginStatus {
                    self.loginViewDelegate?.goToTabBarController()
                } else {
                    self.loginViewDelegate?.updateErrorLabel(text: "Login unsuccessful.")
                }
            }
        } else {
            self.loginViewDelegate?.updateErrorLabel(text: "No internet.")
        }
    }
    
}
