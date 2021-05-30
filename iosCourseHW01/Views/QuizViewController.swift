//
//  QuizViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 06.05.2021..
//

import UIKit

class QuizViewController: GradientViewController, QuizViewDelegate {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private let questionPresenter = QuestionPresenter()
    
    private var insetView: UIView!
    private var questionTrackerView: UIView!
    private var questionLabel: UILabel!
    
    private var answerButtons: [UIButton] = []
    
    convenience init(router: AppRouterProtocol, question: Question, quizPresenter: QuizPresenter) {
        self.init(router: router)
        questionPresenter.setQuestion(question: question)
        questionPresenter.setQuizPresenter(quizPresenter: quizPresenter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        createViews()
        styleViews()
        createConstraints()
        addActions()
        
        questionPresenter.setViewDelegate(quizViewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white
        
        let navbarTitle = UILabel()
        navbarTitle.text = "PopQuiz"
        navbarTitle.textColor = .white
        navbarTitle.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        navigationItem.titleView = navbarTitle
    }
    
    func createViews() {
        insetView = UIView()
        view.addSubview(insetView)
        
        questionTrackerView = QuestionTrackerView(quizPresenter: questionPresenter.getQuizPresenter())
        insetView.addSubview(questionTrackerView)
        
        questionLabel = UILabel()
        insetView.addSubview(questionLabel)
        
        for _ in 0...(questionPresenter.getQuestion().answers.count - 1) {
            let answerButton = UIButton()
            insetView.addSubview(answerButton)
            answerButtons.append(answerButton)
        }
    }
    
    func styleViews() {
        let question = questionPresenter.getQuestion()
        
        questionLabel.text = question.question
        questionLabel.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        
        for i in 0...(question.answers.count - 1) {
            let answerButton = answerButtons[i]
            
            answerButton.setTitle(questionPresenter.getAnswer(index: i), for: .normal)
            answerButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            answerButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 20)
            answerButton.layer.cornerRadius = CORNER_RADIUS
            answerButton.tag = i
        }
    }
    
    func createConstraints() {
        insetView.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
        questionTrackerView.snp.makeConstraints { make -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        questionLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(questionTrackerView.snp.bottom).offset(50)
            make.left.width.equalToSuperview()
        }
        
        for i in 0...(questionPresenter.getQuestion().answers.count - 1) {
            let answerButton = answerButtons[i]
            
            answerButton.snp.makeConstraints { make -> Void in
                make.top.equalTo(i == 0 ? questionLabel.snp.bottom : answerButtons[i - 1].snp.bottom).offset(i == 0 ? 30 : 15)
                make.leading.trailing.equalToSuperview()
            }
        }
    }
    
    func addActions() {
        for answerButton in answerButtons {
            answerButton.addTarget(self, action: #selector(questionAnswered(sender:)), for: .touchUpInside)
        }
    }
    
    func markCorrectButtonGreen(index: Int) {
        answerButtons[index].backgroundColor = UIColor(hex: "#6FCF97FF")
    }
    
    func markWrongButtonRed(index: Int) {
        answerButtons[index].backgroundColor = UIColor(hex: "#FC6565FF")
    }
    
    @objc
    private func questionAnswered(sender: UIButton) {
        for answerButton in answerButtons {
            answerButton.isEnabled = false
        }
        
        questionPresenter.checkAnswer(tag: sender.tag)
    }
    
}
