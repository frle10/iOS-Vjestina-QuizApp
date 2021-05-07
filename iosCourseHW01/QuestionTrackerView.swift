//
//  QuestionTrackerView.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//
import Foundation
import SnapKit
import UIKit

class QuestionTrackerView: UIView {
    
    private var pageController: QuizPageViewController!
    
    private var progressLabel: UILabel!
    private var progressStack: UIStackView!
    
    convenience init(pageController: QuizPageViewController) {
        self.init()
        self.pageController = pageController
        
        createViews()
        styleViews()
        createConstraints()
    }
    
    func createViews() {
        progressLabel = UILabel()
        addSubview(progressLabel)
        
        progressStack = UIStackView()
        addSubview(progressStack)
    }
    
    func styleViews() {
        let currentQuestion = pageController.getCurrentQuestion()
        let totalQuestions = pageController.getNumberOfQuestions()
        
        progressLabel.textColor = .white
        progressLabel.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        progressLabel.text = "\(currentQuestion + 1)/\(totalQuestions)"
        
        let answers = pageController.getAnswers()
        
        for i in 0...(totalQuestions - 1) {
            let rect = UIView()
            
            if i == currentQuestion {
                rect.backgroundColor = .white
            } else if answers[i] == true {
                rect.backgroundColor = UIColor(hex: "#6FCF97FF")
            } else if answers[i] == false {
                rect.backgroundColor = UIColor(hex: "#FC6565FF")
            } else {
                rect.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            }
            
            rect.layer.cornerRadius = 3
            
            rect.snp.makeConstraints { make -> Void in
                make.width.equalTo(40)
                make.height.equalTo(6)
            }
            
            progressStack.addArrangedSubview(rect)
        }
        
        progressStack.axis = .horizontal
        progressStack.alignment = .center
        progressStack.distribution = .equalSpacing
    }
    
    func createConstraints() {
        progressLabel.snp.makeConstraints { make -> Void in
            make.top.leading.trailing.equalToSuperview()
        }
        
        progressStack.snp.makeConstraints { make -> Void in
            make.top.equalTo(progressLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
