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
    
    private let CORNER_RADIUS: CGFloat = 10
    
    private var appNameLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var errorLabel: UILabel!
    
    private var gradientLayer: CAGradientLayer!
    
    private var dataService = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        createConstraints()
        addActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func createViews() {
        appNameLabel = UILabel()
        view.addSubview(appNameLabel)
        
        emailTextField = TextFieldWithPadding()
        view.addSubview(emailTextField)
        
        passwordTextField = TextFieldWithPadding()
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        view.addSubview(loginButton)
        
        errorLabel = UILabel()
        view.addSubview(errorLabel)
    }
    
    private func styleViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(hex: "#744FA3FF").cgColor, UIColor(hex: "#272F76FF").cgColor]
        gradientLayer.locations = [0.1, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        appNameLabel.text = "PopQuiz"
        appNameLabel.textColor = .white
        appNameLabel.font = UIFont(name: "SourceSansPro-Bold", size: 32)
        
        emailTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 16)!])
        emailTextField.layer.cornerRadius = CORNER_RADIUS
        
        passwordTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 16)!])
        passwordTextField.layer.cornerRadius = CORNER_RADIUS
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        loginButton.setTitleColor(UIColor(hex: "#6329DEFF"), for: .normal)
        loginButton.layer.cornerRadius = CORNER_RADIUS
        loginButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        loginButton.isEnabled = false
        
        errorLabel.text = "Login unsuccessful."
        errorLabel.font = UIFont(name: "SourceSansPro-Regular", size: 14)
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
        loginButton.backgroundColor = loginButton.isEnabled ? UIColor.white : UIColor.white.withAlphaComponent(0.5);
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
