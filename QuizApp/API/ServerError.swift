//
//  ServerResponse.swift
//  QuizApp
//
//  Created by Luka Cicak on 13.05.2021..
//

import Foundation

enum ServerError: String, Codable{
    case unauthorized = "401 UNAUTHORIZED"
    case forbidden = "403 FORBIDDEN"
    case notFound = "404 NOT FOUND"
    case badRequest = "400 BAD REQUEST"
    case ok = "200 OK"
    
}




