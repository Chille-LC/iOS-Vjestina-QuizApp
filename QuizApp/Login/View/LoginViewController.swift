//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 12.04.2021..
//

import UIKit
import Foundation
import SnapKit

class LoginViewController:UIViewController, UITextFieldDelegate{
    
    private var emailField: TextFieldWithPadding!
    private var passwordField: TextFieldWithPadding!
    private var appName: UILabel!
    private var loginButton: RoundButton!
    private var layerGradient: CAGradientLayer!
    private var loginStatus: LoginStatus!
    private var loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        buildViews()
        addConstraints()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        [emailField, passwordField].forEach {$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)}
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    
    private func buildViews(){
                
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [Colors.purple1.cgColor,
                                Colors.darkBlue.cgColor]
        
        appName = UILabel()
        appName.textColor = .white
        appName.text = "PopQuiz"
        appName.font = UIFont(name: "SourceSansPro-Black", size: 38)
        appName.textAlignment = .center
        appName.adjustsFontSizeToFitWidth = true
        
    
        passwordField = TextFieldWithPadding()
        passwordField.isSecureTextEntry = true
        passwordField.textAlignment = .left
        passwordField.font = UIFont(name: "SourceSansPro-Black", size: 15)
        passwordField.textColor = .white
        passwordField.backgroundColor = .white.withAlphaComponent(0.3)
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6),
                                 NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Light", size: 20)!])
        
        
        
        emailField = TextFieldWithPadding()
        emailField.textAlignment = .left
        emailField.font = UIFont(name: "SourceSansPro-Black", size: 15)
        emailField.textColor = .white
        emailField.backgroundColor = .white.withAlphaComponent(0.3)
        emailField.attributedPlaceholder = NSAttributedString(string: "Email",
                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6),
                               NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Light", size: 20)!])

        
        loginButton = RoundButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .white.withAlphaComponent(0.55)
        loginButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        loginButton.setTitleColor(UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 1), for: .normal)
        loginButton.setTitleColor(UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 0.8), for: .disabled)
        loginButton.isEnabled = false
        
        view.layer.insertSublayer(layerGradient, at: 0)
        view.addSubview(appName)
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(loginButton)
    }
    
    private func addConstraints(){
        appName.snp.makeConstraints{ make -> Void in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        passwordField.snp.makeConstraints{ make -> Void in
            make.width.equalTo(appName).multipliedBy(1.72)
            make.height.equalTo(appName).multipliedBy(0.95)
            make.center.equalToSuperview()
            
        }
        
        emailField.snp.makeConstraints{ make -> Void in
            make.width.height.equalTo(passwordField)
            make.bottom.equalTo(passwordField.snp.top).offset(-20)
            make.centerX.equalTo(passwordField)
        }
        
        loginButton.snp.makeConstraints{make -> Void in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.width.height.equalTo(passwordField)
            make.centerX.equalTo(passwordField)
        }
    }
    
    
    
    @objc func editingChanged(_ textField: UITextField){
        
        if (emailField.text != "" && passwordField.text != ""){
            loginButton.isEnabled = true
            loginButton.backgroundColor = .white
        }
        else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .white.withAlphaComponent(0.55)
        }
    }
    
    
    @objc func loginButtonPressed(){
        loginPresenter.verifyLogin(viewCont: self, username: emailField.text!, password: passwordField.text!)
    }
    
    
    @objc func fieldIsActive(_ textField: UITextField){
        
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
        if textField == emailField{
            emailField.layer.borderColor = UIColor.white.cgColor
            emailField.layer.borderWidth = 1
        }
        else if textField == passwordField{
            passwordField.layer.borderColor = UIColor.white.cgColor
            passwordField.layer.borderWidth = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField == emailField{
            emailField.layer.borderWidth = 0
        }
        else if textField == passwordField{
            passwordField.layer.borderWidth = 0
        }
    }
    
    override func viewDidLayoutSubviews(){
        
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
    
   
}

