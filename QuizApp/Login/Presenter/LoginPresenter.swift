//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Luka Cicak on 15.05.2021..
//

import Foundation
import UIKit

class LoginPresenter {
    
    private var userDefaults: UserDefaults!
    
    func showAlert(viewCont: LoginViewController) {
        let alertController = UIAlertController(title: "Error", message:
            "Wrong username or password.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        viewCont.present(alertController, animated: true, completion: nil)
    }
    
    func verifyLogin(viewCont: LoginViewController, username: String, password: String) {
        let urlText = "https://iosquiz.herokuapp.com/api/session?username=" + username + "&password=" + password
        let url = URL(string: urlText)!
        var request = URLRequest(url: url)
        let networkService = NetworkService()
 
            
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkService.executeUrlRequest(request) { (result: Result<LoginResponse, RequestError>) in
            print("Usao")
            switch result {
                case .failure(let error):
                    print(error)
                    self.showAlert(viewCont: viewCont)
                case .success(let value):
                    print(value.id)
                    print(value.token)
                    UserDefaults.standard.setValue(value.token, forKey: "token")
                    UserDefaults.standard.setValue(value.id, forKey: "user_id")
                    DispatchQueue.main.async {
                        let vc = createTabBarViewController()
                        viewCont.navigationController?.setViewControllers([vc], animated: true)
                    }
                    
            }
        }
    }
}
