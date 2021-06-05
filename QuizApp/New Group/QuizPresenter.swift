//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by Luka Cicak on 14.05.2021..
//

import Foundation
import UIKit

protocol QuestionViewDelegate: NSObjectProtocol {
    func checkAnswer(sender: UIButton, buttons: [UIButton], view: QuestionViewController, indexProgress: Int)
    func getQuestionText() -> String
    func getAnswer(index: Int) -> String
}

class QuestionPresenter {
    weak private var questionViewDelegate: QuestionViewDelegate?
    private var question: Question!
    
    init(questionPassed: Question) {
        self.question = questionPassed
    }
    
    func setViewDelegate(questionViewDelegate: QuestionViewDelegate?){
        self.questionViewDelegate = questionViewDelegate
    }
    
    func checkAnswer(sender: UIButton, buttons: [UIButton], view: QuestionViewController, indexProgress: Int){
        let parentViewCont = view.parent as! QuizPageViewController
        let correctAnswer = question.answers[question.correctAnswer]
        
        if (sender.currentTitle == correctAnswer) {
            sender.backgroundColor = .green
            parentViewCont.goToNextPage(correct: true, index: indexProgress)

        }
        else{
            for button in buttons {
                if (button.currentTitle == correctAnswer){
                    button.backgroundColor = .green
                }
            }
            sender.backgroundColor = .red
            parentViewCont.goToNextPage(correct: false, index: indexProgress)
        }
    }
    
    func getQuestionText() -> String{
        return question.question
    }
    
    func getAnswer(index: Int) -> String{
        return question.answers[index]
    }
}
