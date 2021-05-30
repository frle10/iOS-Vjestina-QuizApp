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
    
    private var resultLabel: UILabel!
    private var seeLeaderboardButton: UIButton!
    private var finishQuizButton: UIButton!
    
    private let quizResultPresenter = QuizResultPresenter(networkService: NetworkService())
    
    convenience init(router: AppRouterProtocol, quizPresenter: QuizPresenter) {
        self.init(router: router)
        quizResultPresenter.setQuizPresenter(quizPresenter: quizPresenter)
        
        quizResultPresenter.sendQuizResult()
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
        
        seeLeaderboardButton = UIButton()
        view.addSubview(seeLeaderboardButton)
        
        finishQuizButton = UIButton()
        view.addSubview(finishQuizButton)
    }
    
    private func styleViews() {
        resultLabel.textColor = .white
        resultLabel.font = UIFont(name: "SourceSansPro-Bold", size: 88)
        
        resultLabel.text = "\(quizResultPresenter.getCorrectAnswers())/\(quizResultPresenter.getQuizPresenter().getAnswers().count)"
        
        seeLeaderboardButton.backgroundColor = .white
        seeLeaderboardButton.setTitle("See Leaderboard", for: .normal)
        seeLeaderboardButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        seeLeaderboardButton.setTitleColor(UIColor(hex: "#6329DEFF"), for: .normal)
        seeLeaderboardButton.layer.cornerRadius = CORNER_RADIUS
        
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
        
        seeLeaderboardButton.snp.makeConstraints { make -> Void in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(120)
            make.height.equalTo(50)
        }
        
        finishQuizButton.snp.makeConstraints { make -> Void in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
    
    private func addActions() {
        seeLeaderboardButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
        finishQuizButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
    }
    
    @objc
    private func showLeaderboard() {
        let vc = LeaderboardViewController(quizId: quizResultPresenter.getQuizPresenter().getQuizId())
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func finishQuiz() {
        router.showTabBarController()
    }
    
}
