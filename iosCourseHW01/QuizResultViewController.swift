//
//  QuizResultViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//

import Foundation
import UIKit

class QuizResultViewController: GradientViewController {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private var pageController: QuizPageViewController!
    
    private var resultLabel: UILabel!
    private var finishQuizButton: UIButton!
    
    convenience init(router: AppRouterProtocol, pageController: QuizPageViewController) {
        self.init(router: router)
        self.pageController = pageController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func createViews() {
        resultLabel = UILabel()
        view.addSubview(resultLabel)
        
        finishQuizButton = UIButton()
        view.addSubview(finishQuizButton)
    }
    
    private func styleViews() {
        resultLabel.textColor = .white
        resultLabel.font = UIFont(name: "SourceSansPro-Bold", size: 88)
        
        let answers = pageController.getAnswers()
        var correctCount = 0
        
        for answer in answers {
            if answer == true {
                correctCount += 1
            }
        }
        
        resultLabel.text = "\(correctCount)/\(answers.count)"
        
        finishQuizButton.backgroundColor = .white
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        finishQuizButton.setTitleColor(UIColor(hex: "#6329DEFF"), for: .normal)
        finishQuizButton.layer.cornerRadius = CORNER_RADIUS
    }
    
    private func createConstraints() {
        resultLabel.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
        }
        
        finishQuizButton.snp.makeConstraints { make -> Void in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
    
    private func addActions() {
        finishQuizButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
    }
    
    @objc
    private func finishQuiz() {
        router.showTabBarController()
    }
    
}
