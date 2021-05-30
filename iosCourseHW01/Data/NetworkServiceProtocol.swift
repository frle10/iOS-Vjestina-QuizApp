//
//  NetworkServiceProtocol.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    
    func login(email: String, password: String, callback: @escaping (LoginStatus) -> Void)

    func fetchQuizzes(token: String, callback: @escaping ([Quiz]) -> Void)
    
    func sendQuizResult(token: String, quizResult: QuizResult)
    
    func fetchLeaderboardForQuiz(token: String, quizId: Int, callback: @escaping ([LeaderboardResult]) -> Void)
    
}
