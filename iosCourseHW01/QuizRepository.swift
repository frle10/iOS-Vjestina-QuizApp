//
//  QuizRepository.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 30.05.2021..
//

import Foundation
import CoreData

class QuizRepository {
    
    private var quizDatabaseDataSource = QuizDatabaseDataSource()
    private var quizNetworkDataSource = QuizNetworkDataSource()
    
    func fetchQuizzes(callback: @escaping ([Quiz]) -> Void) {
        let quizzes: [Quiz] = quizDatabaseDataSource.fetchQuizzes()
        
        if !quizzes.isEmpty {
            callback(quizzes)
        }
        
        quizNetworkDataSource.fetchQuizzes(callback: callback)
    }
    
    func fetchQuizzesWithFilter(filter: String) -> [Quiz] {
        let quizzes: [Quiz] = quizDatabaseDataSource.fetchQuizzesWithFilter(filter: filter)
        return quizzes
    }
    
    func saveQuizzes(quizzes: [Quiz]) {
        quizDatabaseDataSource.saveQuizzes(quizzes: quizzes)
    }
    
    func clearQuizzes() {
        quizDatabaseDataSource.clearQuizzes()
    }
    
}
