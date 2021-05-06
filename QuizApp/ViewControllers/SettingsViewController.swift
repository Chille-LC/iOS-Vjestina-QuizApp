//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 02.05.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController, UITextFieldDelegate{
    
    private var usernameStatement: UILabel!
    private var username: UILabel!
    private var logoutButton: RoundButton!
    private var layerGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    private func buildViews(){
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1).cgColor,
                                UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1).cgColor]
        
        usernameStatement = UILabel()
        usernameStatement.text = "USERNAME"
        usernameStatement.textColor = .white
        usernameStatement.font = UIFont(name: "SourceSansPro-Light", size: 20)
        usernameStatement.textAlignment = .left
        usernameStatement.adjustsFontSizeToFitWidth = true
        
        username = UILabel()
        username.text = "Luka Čičak"
        username.textAlignment = .left
        username.adjustsFontSizeToFitWidth = true
        username.textColor = .white
        username.font = UIFont(name: "SourceSansPro-SemiBold", size: 35)
        username.adjustsFontSizeToFitWidth = true
        
        logoutButton = RoundButton()
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        logoutButton.setTitleColor(UIColor(red: 0.99, green: 0.40, blue: 0.40, alpha: 1.00), for: .normal)
        
        view.layer.addSublayer(layerGradient)
        view.addSubview(logoutButton)
        view.addSubview(username)
        view.addSubview(usernameStatement)
    }
    
    private func addConstraints(){
        
        usernameStatement.snp.makeConstraints{ make -> Void in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(15)
        }
        
        username.snp.makeConstraints{ make -> Void in
            make.top.equalTo(usernameStatement.snp.bottom).offset(5)
            make.left.equalTo(usernameStatement.snp.left)
        }
        
        logoutButton.snp.makeConstraints{ make -> Void in
            make.top.equalTo(view.snp.centerY).multipliedBy(1.5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
        }
    }
    
    @objc func logoutButtonPressed(){
        self.navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
}
