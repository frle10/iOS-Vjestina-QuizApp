//
//  QuizSearchPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 30.05.2021..
//

import Foundation

protocol QuizSearchViewDelegate: NSObjectProtocol {
    func updateTableData()
}

class QuizSearchPresenter {
    
    private let quizRepository: QuizRepository
    weak private var quizSearchViewDelegate: QuizSearchViewDelegate?
    
    private var quizzes: [Quiz] = []
    private var categories: [QuizCategory] = []
    
    init(quizRepository: QuizRepository) {
        self.quizRepository = quizRepository
    }
    
    func setViewDelegate(quizSearchViewDelegate: QuizSearchViewDelegate?) {
        self.quizSearchViewDelegate = quizSearchViewDelegate
    }
    
    func fetchQuizzesWithFilter(filter: String) {
        let filteredQuizzes: [Quiz] = quizRepository.fetchQuizzesWithFilter(filter: filter)
        self.quizzes = filteredQuizzes
        
        self.categories = Array(Set(quizzes.map { $0.category })).sorted { $0.rawValue > $1.rawValue }
        self.quizSearchViewDelegate?.updateTableData()
    }
    
    func getCurrentQuiz(section: Int, row: Int) -> Quiz {
        let quizzesInSection: [Quiz] = quizzes.filter { $0.category == categories[section] }
        let currentQuiz: Quiz = quizzesInSection[row]
        
        return currentQuiz
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return quizzes.map { $0.category }.filter { $0 == categories[section] }.count
    }
    
    func getQuizzes() -> [Quiz] {
        return quizzes
    }
    
    func getCategories() -> [QuizCategory] {
        return categories
    }
    
}
