//
//  LoginViewController.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.04.2021..
//
import Foundation
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    private var appNameLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var errorLabel: UILabel!
    
    private var dataService = DataService()
    
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
        
        emailTextField = TextFieldWithPadding()
        view.addSubview(emailTextField)
        
        passwordTextField = TextFieldWithPadding()
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.setTitle("Login", for: .normal)
        
        errorLabel = UILabel()
        view.addSubview(errorLabel)
        errorLabel.text = "Login unsuccessful."
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red: 0.453, green: 0.309, blue: 0.637, alpha: 1).cgColor, UIColor(red: 0.152, green: 0.184, blue: 0.461, alpha: 1).cgColor]
        gradient.locations = [0.1, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        
        appNameLabel.textColor = .white
        appNameLabel.font = UIFont(name: "Arial-BoldMT", size: 32)
        
        emailTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.layer.cornerRadius = 10
        
        passwordTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.isSecureTextEntry = true
        
        loginButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        loginButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.867, alpha: 1), for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        loginButton.isEnabled = false
        
        errorLabel.textColor = .white
        errorLabel.isHidden = true
    }
    
    private func createConstraints() {
        appNameLabel.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }
        
        emailTextField.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.size.equalTo(CGSize(width: 280, height: 40))
        }
        
        passwordTextField.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 280, height: 40))
        }
        
        loginButton.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 280, height: 40))
        }
        
        errorLabel.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(10)
        }
    }
    
    private func addActions() {
        emailTextField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc
    private func textfieldChanged() {
        errorLabel.isHidden = true
        loginButton.isEnabled = emailTextField.text != "" && passwordTextField.text != ""
        
        if loginButton.isEnabled {
            loginButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            loginButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        }
    }
    
    @objc
    private func login() {
        let loginResult = dataService.login(email: emailTextField.text!, password: passwordTextField.text!)
        
        if case LoginStatus.success = loginResult {
            print("Username: " + emailTextField.text!)
            print("Password: " + passwordTextField.text!)
        } else {
            errorLabel.isHidden = false
            print("Login unsuccessful.")
        }
    }
    
}
