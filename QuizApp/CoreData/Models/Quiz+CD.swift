//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Luka Cicak on 29.05.2021..
//

import CoreData
import UIKit

extension Quiz{
    
    init(with entity: CDQuiz) {
        id = Int(entity.identifier)
        title = entity.title!
        description = entity.quizDescription!
        category = QuizCategory(rawValue: entity.category!)!
        level = Int(entity.level)
        imageUrl = entity.image!
        questions = entity.getQuestions()
    }
    
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext){
        entity.identifier = Int16(id)
        entity.title = title
        entity.quizDescription = description
        entity.category = category.rawValue
        entity.level = Int16(level)
        entity.image = imageUrl
    }
    
        
}
