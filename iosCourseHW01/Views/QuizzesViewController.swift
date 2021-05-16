//
//  QuizzesViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.04.2021..
//

import Foundation
import SnapKit
import UIKit

class QuizzesViewController: GradientViewController, QuizzesViewDelegate {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    let cellIdentifier = "cellId"
    
    private var quizzesScrollView: UIScrollView!
    private var quizzesView: UIView!
    
    private var appNameLabel: UILabel!
    private var getQuizButton: UIButton!
    private var funFactLabel: UILabel!
    private var nbaCountLabel: UILabel!
    private var quizTable: UITableView!
    
    private var errorLabel: UILabel!
    
    private let quizzesPresenter = QuizzesPresenter(networkService: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
        
        quizzesPresenter.setViewDelegate(quizzesViewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func createViews() {
        quizzesScrollView = UIScrollView()
        view.addSubview(quizzesScrollView)
        
        quizzesView = UIView()
        quizzesScrollView.addSubview(quizzesView)
        
        appNameLabel = UILabel()
        quizzesView.addSubview(appNameLabel)
        
        getQuizButton = UIButton()
        quizzesView.addSubview(getQuizButton)
        
        funFactLabel = UILabel()
        quizzesView.addSubview(funFactLabel)
        
        nbaCountLabel = UILabel()
        quizzesView.addSubview(nbaCountLabel)
        
        errorLabel = UILabel()
        quizzesView.addSubview(errorLabel)
        
        quizTable = UITableView()
        quizzesView.addSubview(quizTable)
        
        quizTable.register(QuizCard.self, forCellReuseIdentifier: cellIdentifier)
        quizTable.dataSource = self
        quizTable.delegate = self
    }
    
    private func styleViews() {
        appNameLabel.text = "PopQuiz"
        appNameLabel.textColor = .white
        appNameLabel.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        
        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.backgroundColor = .white
        getQuizButton.setTitleColor(UIColor(hex: "#6329DEFF"), for: .normal)
        getQuizButton.layer.cornerRadius = 2 * CORNER_RADIUS
        getQuizButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        
        funFactLabel.text = "💡 Fun Fact"
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        funFactLabel.isHidden = true
        
        nbaCountLabel.text = ""
        nbaCountLabel.isHidden = true
        nbaCountLabel.textColor = .white
        nbaCountLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 18)
        nbaCountLabel.numberOfLines = 0
        
        errorLabel.text = "Data can't be reached."
        errorLabel.textColor = .white
        errorLabel.font = UIFont(name: "SourceSansPro-Regular", size: 16)
        errorLabel.isHidden = true
        
        quizTable.backgroundColor = .clear
        quizTable.rowHeight = 150
        quizTable.sectionHeaderHeight = 50
        quizTable.isScrollEnabled = false
        quizTable.isHidden = true
    }
    
    private func createConstraints() {
        quizzesScrollView.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 60, left: 20, bottom: 30, right: 20))
        }
        
        quizzesView.snp.makeConstraints { make -> Void in
            make.edges.width.equalToSuperview()
            make.height.equalTo(800)
        }
        
        appNameLabel.snp.makeConstraints { make -> Void in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        getQuizButton.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 250, height: 35))
        }
        
        funFactLabel.snp.makeConstraints { make -> Void in
            make.left.right.equalToSuperview()
            make.top.equalTo(getQuizButton.snp.bottom).offset(30)
        }
        
        nbaCountLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(funFactLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
        }
        
        quizTable.snp.makeConstraints { make -> Void in
            make.top.equalTo(nbaCountLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(quizzesView.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func addActions() {
        getQuizButton.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
    }
    
    func showErrorLabel() {
        funFactLabel.isHidden = true
        nbaCountLabel.isHidden = true
        quizTable.isHidden = true
        
        errorLabel.isHidden = false
    }
    
    func updateTableData() {
        errorLabel.isHidden = true
        
        self.nbaCountLabel.text = "There are \(quizzesPresenter.getNbaCount()) questions that contain the word \"NBA\""
        self.nbaCountLabel.isHidden = false
        
        self.funFactLabel.isHidden = false
        
        self.quizTable.reloadData()
        self.quizTable.isHidden = false
    }
    
    @objc
    private func getQuizzes() {
        quizzesPresenter.fetchQuizzes()
    }
    
}

extension QuizzesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesPresenter.getCategories().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesPresenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QuizCard = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! QuizCard
        
        let currentQuiz: Quiz = quizzesPresenter.getCurrentQuiz(section: indexPath.section, row: indexPath.row)
        
        cell.title.text = currentQuiz.title
        cell.desc.text = currentQuiz.description
        cell.difficulty.text = "Difficulty: \(currentQuiz.level)"
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.textColor = UIColor(hex: "#F2C94CFF")
        headerView.text = quizzesPresenter.getCategories()[section].rawValue
        headerView.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        
        return headerView
    }
    
}

extension QuizzesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentQuiz: Quiz = quizzesPresenter.getCurrentQuiz(section: indexPath.section, row: indexPath.row)
        router.showQuizController(quiz: currentQuiz)
    }
    
}
