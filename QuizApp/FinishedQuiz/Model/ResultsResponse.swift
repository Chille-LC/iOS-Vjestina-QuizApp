//
//  ResultsResponse.swift
//  QuizApp
//
//  Created by Luka Cicak on 15.05.2021..
//

import Foundation

struct ResultResponse: Decodable{
    var error: ServerError?
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}
