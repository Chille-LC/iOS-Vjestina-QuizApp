//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Luka Cicak on 13.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    
    func executeUrlRequest<T: Decodable> (_request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}
