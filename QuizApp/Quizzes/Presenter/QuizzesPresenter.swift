//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Luka Cicak on 14.05.2021..
//

import Foundation
import UIKit

class QuizzesPresenter {
    
    private var quizzes: [[Quiz]]!
    private var quizzesUnsectioned: [Quiz]!
    private var noOfNBA = ""
    
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
    
    func getFact() -> String {
        return noOfNBA
    }
    
    func fetchQuizzes(viewController: QuizzesViewController){
        
        DispatchQueue.main.async {
            let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes")!
            var request = URLRequest(url: url)
            let networkService = NetworkService()
            
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            networkService.executeUrlRequest(request) { (result: Result<QuizResponse, RequestError>) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    self.quizzes = self.sectionQuizzes(quizzes: value.quizzes)
                    self.noOfNBA = self.configureFunFact()
                    DispatchQueue.main.async {
                        viewController.configurTableView()
                    }
                }
            }
        }
    }
    
    func configureFunFact() -> String {
        let noOfNBA = quizzesUnsectioned.flatMap({$0.questions}).filter({$0.question.contains("NBA")}).count
        return "There are" + " \(noOfNBA) " + "questions that contain the word \"NBA\" "
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
