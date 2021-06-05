//
//  QuizDatabaseDataSource.swift
//  QuizApp
//
//  Created by Luka Cicak on 29.05.2021..
//

import Foundation
import CoreData

struct QuizDatabaseDataSource: QuizDatabaseProtocol {
    
    private let managedContext: NSManagedObjectContext
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func fetchQuizzes() -> [Quiz] {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        let categorySort = NSSortDescriptor(key:"category", ascending: true)
        request.sortDescriptors = [categorySort]
        
        do {
            let results = try managedContext.fetch(request).map { Quiz(with: $0) }
            return results
            
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
    
    func fetchQuizzesFiltered(filter: FilterSettings) -> [Quiz] {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        var namePredicate = NSPredicate(value: true)
        
        if let text = filter.searchText, !text.isEmpty {
            namePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDQuiz.title), text)
        }
        request.predicate = namePredicate

        do {
            let results = try managedContext.fetch(request).map { Quiz(with: $0) }
            return results
            
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }

    func saveQuizzes(_ quizzes: [Quiz]) {
        
        quizzes.forEach { quiz in
            do {
                let cdQuiz = try fetchQuiz(withId: quiz.id) ?? CDQuiz(context: managedContext)
                quiz.populate(cdQuiz, in: managedContext)
                
                quiz.questions.forEach { question in
                    let cdQuestion = CDQuestion(context: managedContext)
                    question.populate(cdQuestion, in: managedContext)
                    cdQuiz.addToQuestions(cdQuestion)
                }
            }
            catch {
                print("Error when fetching/creating a quiz: \(error)")
            }

            do {
                try managedContext.save()
            }
            catch {
                print("Error when saving updated quiz: \(error)")
            }
        }
    }



    private func fetchQuiz(withId id: Int) throws -> CDQuiz? {
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        let predicate = NSPredicate(format: "identifier = %@", "\(id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            return try managedContext.fetch(request).first
        }
        catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
        return nil
        }
    }

}
