//
//  RequestError.swift
//  QuizApp
//
//  Created by Luka Cicak on 11.05.2021..
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}
