//
//  QuizResultPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol QuizResultViewDelegate: NSObjectProtocol {
    
}

class QuizResultPresenter {
    
    private let networkService: NetworkService
    weak private var quizResultViewDelegate: QuizResultViewDelegate?
    private var quizPresenter: QuizPresenter!
    
    private var correctAnswers = 0
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setViewDelegate(quizResultViewDelegate: QuizResultViewDelegate?) {
        self.quizResultViewDelegate = quizResultViewDelegate
    }
    
    func setQuizPresenter(quizPresenter: QuizPresenter) {
        self.quizPresenter = quizPresenter
    }
    
    func getCorrectAnswers() -> Int {
        return correctAnswers
    }
    
    func getQuizPresenter() -> QuizPresenter {
        return quizPresenter
    }
    
    func sendQuizResult() {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let userId = defaults.integer(forKey: "userId")
        
        let quizId = quizPresenter.getQuizId()
        let time = quizPresenter.getElapsedTime()
        
        let answers = quizPresenter.getAnswers()
        var correctCount = 0
        
        for answer in answers {
            if answer == true {
                correctCount += 1
            }
        }
        
        self.correctAnswers = correctCount
        
        let quizResult = QuizResult(userId: userId, quizId: quizId, time: time, correctAnswers: self.correctAnswers)
        networkService.sendQuizResult(token: token!, quizResult: quizResult)
    }
    
}
