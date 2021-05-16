//
//  LeaderboardPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol LeaderboardViewDelegate: NSObjectProtocol {
    func updateTableData()
}

class LeaderboardPresenter {
    
    private let networkService: NetworkService
    weak private var leaderboardViewDelegate: LeaderboardViewDelegate?
    
    private var leaderboardResults: [LeaderboardResult] = []
    private var quizId: Int?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setViewDelegate(leaderboardViewDelegate: LeaderboardViewDelegate?) {
        self.leaderboardViewDelegate = leaderboardViewDelegate
    }
    
    func getQuizId() -> Int? {
        return quizId
    }
    
    func setQuizId(quizId: Int) {
        self.quizId = quizId
    }
    
    func getCurrentResult(row: Int) -> LeaderboardResult {
        return leaderboardResults[row]
    }
    
    func getLeaderboardResults() -> [LeaderboardResult] {
        return leaderboardResults
    }
    
    func fetchLeaderboardForQuiz() {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        networkService.fetchLeaderboardForQuiz(token: token!, quizId: quizId!) { leaderboardResults in
            self.leaderboardResults = leaderboardResults
            self.leaderboardViewDelegate?.updateTableData()
        }
    }

}
