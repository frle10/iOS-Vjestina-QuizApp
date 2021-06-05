//
//  QuizNetworkDataSource.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 30.05.2021..
//

import Foundation

class QuizNetworkDataSource {
    
    private let networkService = NetworkService()
    
    func fetchQuizzes(callback: @escaping ([Quiz]) -> Void) {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        let netConnection = NetMonitor.shared
        let status = netConnection.netOn
        
        if status {
            networkService.fetchQuizzes(token: token!, callback: callback)
        } else {
            callback([])
        }
    }
    
}
