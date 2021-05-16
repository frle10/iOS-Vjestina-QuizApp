//
//  QuizzesPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol QuizzesViewDelegate: NSObjectProtocol {
    func updateTableData()
    func showErrorLabel()
}

class QuizzesPresenter {
    
    private let networkService: NetworkService
    weak private var quizzesViewDelegate: QuizzesViewDelegate?
    
    private var quizzes: [Quiz] = []
    private var categories: [QuizCategory] = []
    private var nbaCount: Int = 0
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setViewDelegate(quizzesViewDelegate: QuizzesViewDelegate?) {
        self.quizzesViewDelegate = quizzesViewDelegate
    }
    
    func fetchQuizzes() {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        
        let netConnection = NetMonitor.shared
        let status = netConnection.netOn
        
        if status {
            networkService.fetchQuizzes(token: token!) { quizzes in
                self.quizzes = quizzes
                
                self.categories = Array(Set(quizzes.map { $0.category })).sorted { $0.rawValue > $1.rawValue }
                
                self.nbaCount = quizzes.map { $0.questions.filter { $0.question.contains("NBA") } }
                    .map { $0.count }
                    .reduce(0, { $0 + $1 })
                
                self.quizzesViewDelegate?.updateTableData()
            }
        } else {
            quizzesViewDelegate?.showErrorLabel()
        }
    }
    
    func getCurrentQuiz(section: Int, row: Int) -> Quiz {
        let quizzesInSection: [Quiz] = quizzes.filter { $0.category == categories[section] }
        let currentQuiz: Quiz = quizzesInSection[row]
        
        return currentQuiz
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return quizzes.map { $0.category }.filter { $0 == categories[section] }.count
    }
    
    func getNbaCount() -> Int {
        return nbaCount
    }
    
    func getQuizzes() -> [Quiz] {
        return quizzes
    }
    
    func getCategories() -> [QuizCategory] {
        return categories
    }
    
}
