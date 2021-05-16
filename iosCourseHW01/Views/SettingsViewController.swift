//
//  SettingsViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 07.05.2021..
//

import Foundation
import UIKit

class SettingsViewController: GradientViewController {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private var usernameLabel: UILabel!
    private var nameLabel: UILabel!
    private var logoutButton: UIButton!
    
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
        usernameLabel = UILabel()
        view.addSubview(usernameLabel)
        
        nameLabel = UILabel()
        view.addSubview(nameLabel)
        
        logoutButton = UIButton()
        view.addSubview(logoutButton)
    }
    
    private func styleViews() {
        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 12)
        
        nameLabel.text = "Ivan Skorupan"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        
        logoutButton.backgroundColor = .white
        logoutButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        logoutButton.setTitleColor(UIColor(hex: "#FC6565FF"), for: .normal)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.layer.cornerRadius = CORNER_RADIUS
    }
    
    private func createConstraints() {
        usernameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make -> Void in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.height.equalTo(50)
        }
    }
    
    private func addActions() {
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc
    private func logout() {
        router.showLoginController()
    }
    
}
