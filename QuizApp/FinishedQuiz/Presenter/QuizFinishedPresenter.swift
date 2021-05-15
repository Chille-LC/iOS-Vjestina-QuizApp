//
//  QuizFinishedPresenter.swift
//  QuizApp
//
//  Created by Luka Cicak on 15.05.2021..
//

import Foundation
import UIKit

class QuizFinishedPresenter {
    
    func showAlert(viewCont: QuizFinishedViewController) {
        let alertController = UIAlertController(title: "Congrats", message:
            "Your score has been uploaded.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        DispatchQueue.main.async {
            viewCont.present(alertController, animated: true, completion: nil)
        }
    }
    
    func sendResults(viewCont: QuizFinishedViewController){
    
        DispatchQueue.main.async {
            let url = URL(string: "https://iosquiz.herokuapp.com/api/result")!
            var request = URLRequest(url: url)
            let networkService = NetworkService()
            let json: [String: Any] = ["quiz_id":UserDefaults.standard.integer(forKey: "quiz_id"),
                                       "user_id": UserDefaults.standard.integer(forKey: "user_id"),
                                       "time": UserDefaults.standard.double(forKey: "time"),
                                       "no_of_correct": UserDefaults.standard.integer(forKey: "no_of_correct")]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            request.httpBody = jsonData
            request.httpMethod = "POST"
            request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        
            networkService.executeUrlRequest(request) { (result: Result<ResultResponse, RequestError>) in
                switch result {
                case .failure(let error):
                    print("Printam result: \(error)")
                case .success(let value):
                    if value.error == nil {
                        DispatchQueue.main.async {
                            self.showAlert(viewCont: viewCont)
                        }
                    }
                }
            }
        }
    }
}
