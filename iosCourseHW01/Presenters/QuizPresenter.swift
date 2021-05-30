//
//  QuizPresenter.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 16.05.2021..
//

import Foundation

protocol QuizPageViewDelegate: NSObjectProtocol {
    func showNextViewController()
}

class QuizPresenter {
    
    private let networkService: NetworkService
    weak private var quizPageViewDelegate: QuizPageViewDelegate?
    
    private var quiz: Quiz!
    private var currentQuestionIndex = 0
    
    private var answers: [Bool?] = []
    
    private var startTime: DispatchTime!
    private var endTime: DispatchTime!
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setViewDelegate(quizPageViewDelegate: QuizPageViewDelegate?) {
        self.quizPageViewDelegate = quizPageViewDelegate
    }
    
    func setQuiz(quiz: Quiz) {
        self.quiz = quiz
    }
    
    func getQuizId() -> Int {
        return quiz.id
    }
    
    func getNumberOfQuestions() -> Int {
        return quiz.questions.count
    }
    
    func getQuestion(index: Int) -> Question {
        return quiz.questions[index]
    }
    
    func getAnswers() -> [Bool?] {
        return answers
    }
    
    func setAnswer(correct: Bool) {
        answers[currentQuestionIndex] = correct
    }
    
    func getCurrentQuestion() -> Question {
        return quiz.questions[currentQuestionIndex]
    }
    
    func getCurrentQuestionIndex() -> Int {
        return currentQuestionIndex
    }
    
    func addAnswer(answer: Bool?) {
        answers.append(answer)
    }
    
    func startClock() {
        startTime = DispatchTime.now()
    }
    
    func endClock() {
        endTime = DispatchTime.now()
    }
    
    func goToNextQuestion() {
        currentQuestionIndex += 1
        quizPageViewDelegate?.showNextViewController()
    }
    
    func getElapsedTime() -> Double {
        return Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
    }
    
}
