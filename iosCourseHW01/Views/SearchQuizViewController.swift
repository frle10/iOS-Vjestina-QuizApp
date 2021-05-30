//
//  SearchQuizViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 30.05.2021..
//

import Foundation
import UIKit

class SearchQuizViewController: GradientViewController, QuizSearchViewDelegate {
    
    let cellIdentifier = "searchCellId"
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private var searchTextField: UITextField!
    private var searchButton: UIButton!
    private var quizTable: UITableView!
    
    private let quizSearchPresenter = QuizSearchPresenter(quizRepository: QuizRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
        
        quizSearchPresenter.setViewDelegate(quizSearchViewDelegate: self)
    }
    
    func createViews() {
        searchTextField = TextFieldWithPadding()
        view.addSubview(searchTextField)
        
        searchButton = UIButton()
        view.addSubview(searchButton)
        
        quizTable = UITableView()
        view.addSubview(quizTable)
        
        quizTable.register(QuizCard.self, forCellReuseIdentifier: cellIdentifier)
        quizTable.dataSource = self
        quizTable.delegate = self
    }
    
    func styleViews() {
        searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        searchTextField.textColor = .white
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 16)!])
        searchTextField.layer.cornerRadius = CORNER_RADIUS
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .clear
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        
        quizTable.backgroundColor = .clear
        quizTable.rowHeight = 150
        quizTable.sectionHeaderHeight = 50
        quizTable.isScrollEnabled = true
        quizTable.isHidden = true
    }
    
    func createConstraints() {
        searchTextField.snp.makeConstraints { make -> Void in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 280, height: 40))
        }
        
        searchButton.snp.makeConstraints { make -> Void in
            make.top.equalTo(searchTextField.snp.top)
            make.left.equalTo(searchTextField.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        quizTable.snp.makeConstraints { make -> Void in
            make.top.equalTo(searchTextField.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func addActions() {
        searchButton.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
    }
    
    func updateTableData() {
        self.quizTable.reloadData()
        self.quizTable.isHidden = false
    }
    
    @objc
    private func performSearch() {
        quizSearchPresenter.fetchQuizzesWithFilter(filter: searchTextField.text ?? "")
    }
    
}

extension SearchQuizViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizSearchPresenter.getCategories().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizSearchPresenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QuizCard = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! QuizCard
        
        let currentQuiz: Quiz = quizSearchPresenter.getCurrentQuiz(section: indexPath.section, row: indexPath.row)
        
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
        headerView.text = quizSearchPresenter.getCategories()[section].rawValue
        headerView.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        
        return headerView
    }
    
}

extension SearchQuizViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentQuiz: Quiz = quizSearchPresenter.getCurrentQuiz(section: indexPath.section, row: indexPath.row)
        router.showQuizController(quiz: currentQuiz)
    }
    
}
