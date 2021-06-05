//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Luka Cicak on 29.05.2021..
//

import Foundation
import CoreData

class QuizRepository: QuizRepositoryProtocol{
    
    private var quizFromNetwork: QuizNetworkProtocol
    private var quizFromCoreData: QuizDatabaseProtocol
    
    init(quizNetworkProtocol: QuizNetworkProtocol, quizDatabaseProtocol: QuizDatabaseProtocol) {
        self.quizFromCoreData = quizDatabaseProtocol
        self.quizFromNetwork = quizNetworkProtocol
    }
    
    func fetchQuizzes(presenter: QuizzesPresenter){
        
        if NetworkMonitor.shared.isConnected{
            quizFromNetwork.fetchQuizzes(presenter: presenter, coreData: quizFromCoreData)
        }
        else {
            let quizzes = quizFromCoreData.fetchQuizzes()
            presenter.setQuizzes(quizArray: quizzes)
            presenter.resultsUploaded()
        }
        
    }
    
    func fetchQuizzesForSearch(presenter: SearchPresenter, filter: FilterSettings) {
        let quizzes = quizFromCoreData.fetchQuizzesFiltered(filter: filter)
        presenter.setQuizzes(quizArray: quizzes)
        presenter.resultsUploaded()
    }
    
}
