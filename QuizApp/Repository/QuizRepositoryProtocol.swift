//
//  QuizRepositoryProtocol.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation

protocol QuizRepositoryProtocol {
    func fetchQuizzes(presenter: QuizzesPresenter)
}
