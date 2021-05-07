//
//  QuizPageViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//
import Foundation
import UIKit

class QuizPageViewController: UIPageViewController {
    
    private var controllers: [UIViewController] = []
    private var answers: [Bool?] = []
    
    private var displayedIndex = 0
    private var quiz: Quiz!
    
    convenience init(router: AppRouterProtocol, quiz: Quiz) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.quiz = quiz
        
        for question in quiz.questions {
            let quizController = QuizViewController(router: router, question: question, pageController: self)
            controllers.append(quizController)
            answers.append(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        guard let firstVC = controllers.first else { return }
        
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
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
    
    func getCurrentQuestion() -> Int {
        return displayedIndex
    }
    
    func nextQuestion() {
        displayedIndex += 1
        setViewControllers([controllers[displayedIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    func setAnswer(correct: Bool) {
        answers[displayedIndex] = correct
    }
    
}
