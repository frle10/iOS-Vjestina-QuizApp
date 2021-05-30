//
//  QuizPageViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//

import Foundation
import UIKit

class QuizPageViewController: UIPageViewController, QuizPageViewDelegate {
    
    private var controllers: [UIViewController] = []
    private var router: AppRouterProtocol!
    
    private let quizPresenter = QuizPresenter(networkService: NetworkService())
    
    convenience init(router: AppRouterProtocol, quiz: Quiz) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.router = router
        
        quizPresenter.setViewDelegate(quizPageViewDelegate: self)
        quizPresenter.setQuiz(quiz: quiz)
        
        for question in quiz.questions {
            let quizController = QuizViewController(router: router, question: question, quizPresenter: quizPresenter)
            controllers.append(quizController)
            quizPresenter.addAnswer(answer: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        guard let firstVC = controllers.first else { return }
        
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        quizPresenter.startClock()
    }
    
    func showNextViewController() {
        let currentQuestionIndex = quizPresenter.getCurrentQuestionIndex()
        
        if currentQuestionIndex < controllers.count {
            setViewControllers([controllers[currentQuestionIndex]], direction: .forward, animated: true, completion: nil)
        } else {
            quizPresenter.endClock()
            router.showQuizResultController(quizPresenter: quizPresenter)
        }
    }
    
}
