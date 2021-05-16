//
//  QuestionPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol QuizViewDelegate: NSObjectProtocol {
    func markCorrectButtonGreen(index: Int)
    func markWrongButtonRed(index: Int)
}

class QuestionPresenter {
    
    weak private var quizViewDelegate: QuizViewDelegate?
    private var quizPresenter: QuizPresenter!
    
    private var question: Question!
    
    func setViewDelegate(quizViewDelegate: QuizViewDelegate?) {
        self.quizViewDelegate = quizViewDelegate
    }
    
    func setQuizPresenter(quizPresenter: QuizPresenter) {
        self.quizPresenter = quizPresenter
    }
    
    func getQuizPresenter() -> QuizPresenter {
        return quizPresenter
    }
    
    func getQuestion() -> Question {
        return question
    }
    
    func setQuestion(question: Question) {
        self.question = question
    }
    
    func getCorrectAnswerIndex() -> Int {
        return question.correctAnswer
    }
    
    func getAnswers() -> [String] {
        return question.answers
    }
    
    func getAnswer(index: Int) -> String {
        return question.answers[index]
    }
    
    func checkAnswer(tag: Int) {
        for i in 0...(question.answers.count - 1) {
            if i == question.correctAnswer {
                quizViewDelegate?.markCorrectButtonGreen(index: i)
                
                if i == tag {
                    self.quizPresenter?.setAnswer(correct: true)
                }
            } else if i == tag {
                quizViewDelegate?.markWrongButtonRed(index: i)
                self.quizPresenter?.setAnswer(correct: false)
            }
        }
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.quizPresenter?.goToNextQuestion()
        }
    }
    
}
