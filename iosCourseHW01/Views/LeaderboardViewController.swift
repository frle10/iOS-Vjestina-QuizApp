//
//  LeaderboardViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 15.05.2021..
//

import Foundation
import UIKit

class LeaderboardViewController: GradientViewController, LeaderboardViewDelegate {
    
    let cellIdentifier = "cellId2"
    
    private var leaderboardLabel: UILabel!
    private var closeButton: UIButton!
    
    private var errorLabel: UILabel!
    
    private var leaderboardTable: UITableView!
    
    private let leaderboardPresenter = LeaderboardPresenter(networkService: NetworkService())
    
    convenience init(quizId: Int) {
        self.init()
        leaderboardPresenter.setQuizId(quizId: quizId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
        
        leaderboardPresenter.setViewDelegate(leaderboardViewDelegate: self)
        
        leaderboardPresenter.fetchLeaderboardForQuiz()
    }
    
    func createViews() {
        leaderboardLabel = UILabel()
        view.addSubview(leaderboardLabel)
        
        closeButton = UIButton()
        view.addSubview(closeButton)
        
        errorLabel = UILabel()
        view.addSubview(errorLabel)
        
        leaderboardTable = UITableView()
        view.addSubview(leaderboardTable)
        
        leaderboardTable.register(LeaderboardCard.self, forCellReuseIdentifier: cellIdentifier)
        leaderboardTable.dataSource = self
        leaderboardTable.delegate = self
    }
    
    func styleViews() {
        leaderboardLabel.text = "Leaderboard"
        leaderboardLabel.textColor = .white
        leaderboardLabel.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        
        errorLabel.text = "Could not fetch leaderboard data."
        errorLabel.font = UIFont(name: "SourceSansPro-Regular", size: 16)
        errorLabel.textColor = .white
        
        closeButton.setBackgroundImage(UIImage(named: "close-button"), for: .normal)
        
        leaderboardTable.backgroundColor = .clear
        leaderboardTable.isHidden = true
        leaderboardTable.separatorColor = .white
        leaderboardTable.separatorStyle = .singleLine
        leaderboardTable.rowHeight = 50
        leaderboardTable.sectionHeaderHeight = 30
    }
    
    func createConstraints() {
        leaderboardLabel.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
        
        closeButton.snp.makeConstraints { make -> Void in
            make.top.bottom.equalTo(leaderboardLabel)
            make.right.equalToSuperview().inset(30)
        }
        
        errorLabel.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
        }
        
        leaderboardTable.snp.makeConstraints { make -> Void in
            make.top.equalTo(leaderboardLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func addActions() {
        closeButton.addTarget(self, action: #selector(dismissLeaderboard), for: .touchUpInside)
    }
    
    func updateTableData() {
        errorLabel.isHidden = true
        leaderboardTable.reloadData()
        leaderboardTable.isHidden = false
    }
    
    func showErrorLabel() {
        leaderboardTable.isHidden = true
        errorLabel.isHidden = false
    }
    
    @objc
    func dismissLeaderboard() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LeaderboardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardPresenter.getLeaderboardResults().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeaderboardCard = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeaderboardCard
        
        let currentResult = leaderboardPresenter.getCurrentResult(row: indexPath.row)
        
        cell.order.text = "\(indexPath.row + 1)."
        cell.username.text = currentResult.username
        
        let score: Double = Double(currentResult.score ?? "0")!
        cell.score.text = String(format: "%.0f", score)
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let playerLabel = UILabel()
        let pointsLabel = UILabel()
        
        headerView.addSubview(playerLabel)
        headerView.addSubview(pointsLabel)
        
        playerLabel.text = "Player"
        playerLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        playerLabel.textColor = .white
        
        pointsLabel.text = "Points"
        pointsLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        pointsLabel.textColor = .white
        
        playerLabel.snp.makeConstraints { make -> Void in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        pointsLabel.snp.makeConstraints { make -> Void in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
}

extension LeaderboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
