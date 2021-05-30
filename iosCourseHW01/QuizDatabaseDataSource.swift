//
//  QuizDatabaseDataSource.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 30.05.2021..
//

import Foundation
import CoreData

class QuizDatabaseDataSource {
    
    private let coreDataStack = CoreDataStack(modelName: "Quiz")
    
    func fetchQuizzes() -> [Quiz] {
        let fetchRequest: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        
        do {
            let cdQuizzes = try coreDataStack.managedContext.fetch(fetchRequest)
            return cdQuizzes.map { Quiz(fromModel: $0) }
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
    
    func fetchQuizzesWithFilter(filter: String) -> [Quiz] {
        let fetchRequest: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[c] %@", filter)
        
        fetchRequest.predicate = predicate
        
        do {
            let cdQuizzes = try coreDataStack.managedContext.fetch(fetchRequest)
            return cdQuizzes.map { Quiz(fromModel: $0) }
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
    
    func saveQuizzes(quizzes: [Quiz]) {
        let quizEntity = NSEntityDescription.entity(forEntityName: "CDQuiz", in: coreDataStack.managedContext)!
        let questionEntity = NSEntityDescription.entity(forEntityName: "CDQuestion", in: coreDataStack.managedContext)!
        
        for quiz in quizzes {
            let cdQuiz = CDQuiz(entity: quizEntity, insertInto: coreDataStack.managedContext)
            var cdQuestions: [CDQuestion] = []
            
            for question in quiz.questions {
                let cdQuestion = CDQuestion(entity: questionEntity, insertInto: coreDataStack.managedContext)
                
                cdQuestion.id = Int16(question.id)
                cdQuestion.question = question.question
                cdQuestion.answers = question.answers
                cdQuestion.correctAnswer = Int16(question.correctAnswer)
                cdQuestion.quiz = cdQuiz
                
                cdQuestions.append(cdQuestion)
            }
            
            cdQuiz.id = Int16(quiz.id)
            cdQuiz.title = quiz.title
            cdQuiz.desc = quiz.description
            cdQuiz.category = quiz.category.rawValue
            cdQuiz.level = Int16(quiz.level)
            cdQuiz.imageUrl = quiz.imageUrl
            cdQuiz.questions = NSSet(array: cdQuestions)
        }
        
        try? coreDataStack.managedContext.save()
    }
    
    func clearQuizzes() {
        let fetchRequest: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        
        do {
            let cdQuizzes = try coreDataStack.managedContext.fetch(fetchRequest)
            
            for cdQuiz in cdQuizzes {
                coreDataStack.managedContext.delete(cdQuiz)
            }
            
            try? coreDataStack.managedContext.save()
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
        }
    }
    
}
