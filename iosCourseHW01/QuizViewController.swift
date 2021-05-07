//
//  QuizViewController.swift
//  iosCourseHW01
//
//  Created by SofaScore Akademija on 06.05.2021..
//
import UIKit

class QuizViewController: GradientViewController {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private var pageController: QuizPageViewController!
    private var question: Question!
    
    private var insetView: UIView!
    private var questionTrackerView: UIView!
    private var questionLabel: UILabel!
    
    private var answerButtons: [UIButton] = []
    
    convenience init(router: AppRouterProtocol, question: Question, pageController: QuizPageViewController) {
        self.init(router: router)
        self.question = question
        self.pageController = pageController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        createViews()
        styleViews()
        createConstraints()
        addActions()
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
        
        questionTrackerView = QuestionTrackerView(pageController: pageController)
        insetView.addSubview(questionTrackerView)
        
        questionLabel = UILabel()
        insetView.addSubview(questionLabel)
        
        for _ in 0...(question.answers.count - 1) {
            let answerButton = UIButton()
            insetView.addSubview(answerButton)
            answerButtons.append(answerButton)
        }
    }
    
    func styleViews() {
        questionLabel.text = question.question
        questionLabel.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        
        for i in 0...(question.answers.count - 1) {
            let answerButton = answerButtons[i]
            
            answerButton.setTitle(question.answers[i], for: .normal)
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
        
        for i in 0...(question.answers.count - 1) {
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
    
    @objc
    private func questionAnswered(sender: UIButton) {
        let correctAnswer = question.correctAnswer
        let tag = sender.tag
        
        for answerButton in answerButtons {
            answerButton.isEnabled = false
        }
        
        if tag == correctAnswer {
            
        }
        
        for i in 0...(answerButtons.count - 1) {
            let answerButton = answerButtons[i]
            
            if i == correctAnswer {
                answerButton.backgroundColor = UIColor(hex: "#6FCF97FF")
                
                if i == tag {
                    pageController.setAnswer(correct: true)
                }
            } else if i == tag {
                answerButton.backgroundColor = UIColor(hex: "#FC6565FF")
                pageController.setAnswer(correct: false)
            }
        }
        
        let currentQuestion = pageController.getCurrentQuestion()
        let questionCount = pageController.getNumberOfQuestions()
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            if currentQuestion < questionCount - 1 {
                self.pageController.nextQuestion()
            } else {
                self.router.showQuizResultController(pageController: self.pageController)
            }
        }
    }
    
}
