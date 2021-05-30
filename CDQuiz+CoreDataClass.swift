//
//  CDQuiz+CoreDataClass.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//
//

import Foundation
import CoreData

@objc(CDQuiz)
public class CDQuiz: NSManagedObject {
    
    func getQuestions() -> [Question] {
        var questionArray: [Question] = []
        self.questions?.forEach{ questionArray.append(Question(with: $0 as! CDQuestion))}
        return questionArray
    }
}
