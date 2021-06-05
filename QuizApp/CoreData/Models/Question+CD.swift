//
//  Question+CD.swift
//  QuizApp
//
//  Created by Luka Cicak on 29.05.2021..
//

import CoreData
import UIKit

extension Question{
    
    init(with entity: CDQuestion){
        id = Int(entity.identifier)
        question = entity.question!
        correctAnswer = Int(entity.correctAnswer)
        answers = entity.answers
    }
    
    func populate(_ entity: CDQuestion, in context: NSManagedObjectContext){
        entity.identifier = Int16(id)
        entity.question = question
        entity.correctAnswer = Int16(correctAnswer)
        entity.answers = answers
    }
}
