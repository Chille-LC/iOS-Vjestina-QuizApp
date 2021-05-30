//
//  SearchPresenter.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation
import UIKit

class SearchPresenter {
    
    var delegate: QuizzesPresenterDelegate?
    private var quizzes: [[Quiz]]!
    private var quizzesUnsectioned: [Quiz]!
    private var quizRepository: QuizRepository!
    
    init() {
        self.quizRepository = QuizRepository(quizNetworkProtocol: QuizNetworkDataSource(), quizDatabaseProtocol: QuizDatabaseDataSource(managedContext: CoreDataStack(modelName: "QuizAppCoreData").managedContext))
    }
    
    
    func resultsUploaded() {
        DispatchQueue.main.async {
            self.delegate?.showSuccessPopup()
        }
    }
    
    func sectionQuizzes(quizzes: [Quiz]) -> [[Quiz]] {
        quizzesUnsectioned = quizzes
        var sectionedQuizzes: [[Quiz]] = []
        let dict = Dictionary(grouping: quizzes, by: { $0.category })
        
        
        for array in dict.values {
            sectionedQuizzes.append(array)
        }
        
        return sectionedQuizzes.sorted(by: { $0[0].category.rawValue < $1[0].category.rawValue})

    }
    
    func getQuizzes() -> [[Quiz]] {
        return quizzes
    }
    
    func setQuizzes(quizArray: [Quiz]){
        self.quizzes = sectionQuizzes(quizzes: quizArray)
    }
    
    func fetchQuizzes(text: String){
        quizRepository.fetchQuizzesForSearch(presenter: self, filter: FilterSettings(searchText: text))
    }
    
    
    func getHeaderText(section: Int) -> String{
        guard let header = quizzes[section].first?.category.rawValue.lowercased().capitalized
        else { return "" }
        
        return "    " + header
    }
    
    func getHeaderColor(section: Int) -> UIColor?{
        let color = CategorizedQuizzes().sectionColors[(quizzes[section].first?.category.rawValue)!]
        return color
    }
    
    func createQuizPageController(quiz: Quiz) -> QuizPageViewController{
        let newQuizPageController = QuizPageViewController()
        var controllers: [QuestionViewController] = []
        var index = 1
        
        for question in quiz.questions {
            let qNumber = "\(index) of \(quiz.questions.count)"
            let vc = QuestionViewController(question: question, questNoText: qNumber, numberOfQuestions: quiz.questions.count )
            
            index += 1
            controllers.append(vc)
        }
        
        for index in 0...controllers.count-1{
            controllers[index].setProgress(index: index)
        }
        
        newQuizPageController.setControllers(controllerArray: controllers)
        return newQuizPageController
    }
}
