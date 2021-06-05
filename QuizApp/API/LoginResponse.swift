//
//  LoginResponse.swift
//  QuizApp
//
//  Created by Luka Cicak on 13.05.2021..
//

import Foundation

struct LoginResponse:Codable {
    let token: String
    let id: Int
    
    enum CodingKeys: String, CodingKey{
        case token
        case id = "user_id"
    }
}
