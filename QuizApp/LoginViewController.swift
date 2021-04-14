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
    
    private var EmailField: TextFieldWithPadding!
    private var PasswordField: TextFieldWithPadding!
    private var AppName: UILabel!
    private var LoginButton: RoundButton!
    private var layerGradient: CAGradientLayer!
    
    let DataSInstance = DataService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        EmailField.delegate = self
        PasswordField.delegate = self
        
        [EmailField, PasswordField].forEach {$0?.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)}
        
        LoginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    
    private func buildViews(){
        
        //view.backgroundColor = UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1)
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1).cgColor,
                                UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1).cgColor]
        
        AppName = UILabel()
        AppName.textColor = .white
        AppName.text = "PopQuiz"
        AppName.font = UIFont(name: "SourceSansPro-Black", size: 38)
        AppName.textAlignment = .center
        AppName.adjustsFontSizeToFitWidth = true
        AppName.translatesAutoresizingMaskIntoConstraints = false
        
    
        PasswordField = TextFieldWithPadding()
        PasswordField.isSecureTextEntry = true
        PasswordField.translatesAutoresizingMaskIntoConstraints = false
        PasswordField.textAlignment = .left
        PasswordField.font = UIFont(name: "SourceSansPro-Black", size: 15)
        PasswordField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PasswordField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        PasswordField.attributedPlaceholder = NSAttributedString(string: "Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6),
                                 NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Light", size: 20)!])
        
        
        
        EmailField = TextFieldWithPadding()
        EmailField.textAlignment = .left
        EmailField.translatesAutoresizingMaskIntoConstraints = false
        EmailField.font = UIFont(name: "SourceSansPro-Black", size: 15)
        EmailField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        EmailField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        EmailField.attributedPlaceholder = NSAttributedString(string: "Email",
                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6),
                               NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Light", size: 20)!])

        
        LoginButton = RoundButton()
        LoginButton.setTitle("Login", for: .normal)
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        LoginButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.55)
        LoginButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        LoginButton.setTitleColor(UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 1), for: .normal)
        LoginButton.setTitleColor(UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 0.8), for: .disabled)
        LoginButton.isEnabled = false
        
        view.layer.addSublayer(layerGradient)
        view.addSubview(AppName)
        view.addSubview(PasswordField)
        view.addSubview(EmailField)
        view.addSubview(LoginButton)
    }
    
    private func addConstraints(){
        AppName.snp.makeConstraints{ make -> Void in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        PasswordField.snp.makeConstraints{ make -> Void in
            make.width.equalTo(AppName).multipliedBy(1.72)
            make.height.equalTo(AppName).multipliedBy(0.95)
            make.center.equalToSuperview()
            
        }
        
        EmailField.snp.makeConstraints{ make -> Void in
            make.width.height.equalTo(PasswordField)
            make.bottom.equalTo(PasswordField.snp.top).offset(-20)
            make.centerX.equalTo(PasswordField)
        }
        
        LoginButton.snp.makeConstraints{make -> Void in
            make.top.equalTo(PasswordField.snp.bottom).offset(20)
            make.width.height.equalTo(PasswordField)
            make.centerX.equalTo(PasswordField)
        }
    }
    
    
    
    @objc func editingChanged(_ textField: UITextField) {
        
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        LoginButton.isEnabled = ![EmailField, PasswordField].compactMap {
            $0.text?.isEmpty
        }.contains(true)
        
        if LoginButton.isEnabled == true {
            LoginButton.backgroundColor = .white
        }
    }
    
    
    @objc func loginButtonPressed(){
        let status = DataSInstance.login(email: EmailField.text!, password: PasswordField.text!)
        
        if case .success = status{
            self.present(QuizzesViewController(), animated: true, completion: nil)
        }
    }
    
    
    @objc func fieldIsActive(_ textField: UITextField){
        PasswordField.layer.borderWidth = 1
        PasswordField.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == EmailField{
            EmailField.layer.borderColor = UIColor.white.cgColor
            EmailField.layer.borderWidth = 1
        }
        else if textField == PasswordField{
            PasswordField.layer.borderColor = UIColor.white.cgColor
            PasswordField.layer.borderWidth = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == EmailField{
            EmailField.layer.borderWidth = 0
        }
        else if textField == PasswordField{
            PasswordField.layer.borderWidth = 0
        }
    }
}

