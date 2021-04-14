//
//  QuizzesViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.04.2021..
//

import Foundation
import SnapKit
import UIKit

class QuizzesViewController: UIViewController {
    
    let cellIdentifier = "cellId"
    
    private var appNameLabel: UILabel!
    private var getQuizButton: UIButton!
    private var funFactLabel: UILabel!
    private var nbaCountLabel: UILabel!
    private var quizTable: UITableView!
    
    private var dataService: DataService = DataService()
    private var quizzes: [Quiz] = []
    private var categories: [QuizCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
    }
    
    private func createViews() {
        appNameLabel = UILabel()
        view.addSubview(appNameLabel)
        appNameLabel.text = "PopQuiz"
        
        getQuizButton = UIButton()
        view.addSubview(getQuizButton)
        getQuizButton.setTitle("Get Quiz", for: .normal)
        
        funFactLabel = UILabel()
        view.addSubview(funFactLabel)
        funFactLabel.text = "💡 Fun Fact"
        
        nbaCountLabel = UILabel()
        view.addSubview(nbaCountLabel)
        nbaCountLabel.text = ""
        nbaCountLabel.isHidden = true
        
        quizTable = UITableView()
        view.addSubview(quizTable)
        quizTable.register(QuizCard.self, forCellReuseIdentifier: cellIdentifier)
        quizTable.dataSource = self
        quizTable.delegate = self
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 0.453, green: 0.309, blue: 0.637, alpha: 1).cgColor, UIColor(red: 0.152, green: 0.184, blue: 0.461, alpha: 1).cgColor]
        gradient.locations = [0.1, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        
        appNameLabel.textColor = .white
        appNameLabel.font = UIFont(name: "Arial-BoldMT", size: 24)
        
        getQuizButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        getQuizButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.867, alpha: 1), for: .normal)
        getQuizButton.layer.cornerRadius = 10
        getQuizButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        
        nbaCountLabel.textColor = .white
        nbaCountLabel.font = UIFont(name: "ArialMT", size: 14)
        nbaCountLabel.numberOfLines = 0
        
        quizTable.backgroundColor = .clear
        quizTable.isHidden = true
        quizTable.isScrollEnabled = true
        quizTable.showsVerticalScrollIndicator = false
    }
    
    private func createConstraints() {
        appNameLabel.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }
        
        getQuizButton.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 250, height: 35))
        }
        
        funFactLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(getQuizButton.snp.left).offset(-10)
            make.top.equalTo(getQuizButton.snp.bottom).offset(30)
        }
        
        nbaCountLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(funFactLabel.snp.bottom).offset(10)
            make.left.equalTo(funFactLabel)
            make.right.equalTo(getQuizButton.snp.right)
        }
        
        quizTable.snp.makeConstraints { make -> Void in
            make.top.equalTo(nbaCountLabel.snp.bottom).offset(20)
            make.left.equalTo(nbaCountLabel.snp.left)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func addActions() {
        getQuizButton.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
    }
    
    @objc
    private func getQuizzes() {
        quizzes = dataService.fetchQuizes()
        categories = Array(Set(quizzes.map { $0.category })).sorted { $0.rawValue > $1.rawValue }
        
        let nbaCount = quizzes.map { $0.questions.filter { $0.question.contains("NBA") } }
            .map { $0.count }
            .reduce(0, { $0 + $1 })
        
        nbaCountLabel.text = "There are \(nbaCount) questions that contain the word \"NBA\""
        nbaCountLabel.isHidden = false
        
        quizTable.reloadData()
        quizTable.isHidden = false
    }
    
}

extension QuizzesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.map { $0.category }.filter { $0 == categories[section] }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! QuizCard
        
        let quizzesInSection = quizzes.filter { $0.category == categories[indexPath.section] }
        let currentQuiz = quizzesInSection[indexPath.row]
        
        cell.title.text = currentQuiz.title
        cell.desc.text = currentQuiz.description
        cell.difficulty.text = "\(currentQuiz.level)"
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.textColor = .orange
        headerView.text = categories[section].rawValue
        
        return headerView
    }
    
}

extension QuizzesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
