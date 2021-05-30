//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by Luka Cicak on 29.05.2021..
//

import Foundation

struct QuizNetworkDataSource: QuizNetworkProtocol {
    
    func fetchQuizzes(presenter: QuizzesPresenter, coreData: QuizDatabaseProtocol){
        
        DispatchQueue.main.async {
            let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes")!
            var request = URLRequest(url: url)
            let networkService = NetworkService()
            
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            networkService.executeUrlRequest(request) { (result: Result<QuizResponse, RequestError>) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    DispatchQueue.main.async {
                        presenter.setQuizzes(quizArray: value.quizzes)
                        presenter.resultsUploaded()
                        coreData.saveQuizzes(value.quizzes)
                    }
                }
            }
        }
    }
}
