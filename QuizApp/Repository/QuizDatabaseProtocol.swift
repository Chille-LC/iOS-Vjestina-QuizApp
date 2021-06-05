//
//  QuizDatabaseProtocol.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation

protocol QuizDatabaseProtocol {
    func fetchQuizzes() -> [Quiz]
    func saveQuizzes(_ quizzes: [Quiz])
    func fetchQuizzesFiltered(filter: FilterSettings) -> [Quiz] 
}
