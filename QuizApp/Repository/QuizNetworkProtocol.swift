//
//  QuizNetworkProtocol.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation

protocol QuizNetworkProtocol {
    func fetchQuizzes(presenter: QuizzesPresenter, coreData: QuizDatabaseProtocol)
}
