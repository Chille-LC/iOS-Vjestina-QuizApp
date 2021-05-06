//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 03.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizViewController:UIViewController{
    
    private var questionLabel:UILabel!
    private var button1:UIButton!
    private var button2:UIButton!
    private var button3:UIButton!
    private var button4:UIButton!
    private var questionNoLabel: UILabel!
    private var layerGradient: CAGradientLayer!
    private var appName:UILabel!
    private var questionTrackerView: UIView!
    
    private var progressArray: [UIView] = []
    private var questionNoText: String!
    private var questionText: String!
    private var answers: [String]!
    private var correctAnswer: String!
    private var numOfQuestions = 0
    private var indexProgress = 0
    
    init(answerList: [String], quesText: String, questNoText: String, correctAnswerIndex: Int, numberOfQuestions: Int) {
        
        self.numOfQuestions = numberOfQuestions
        self.answers = answerList
        self.questionText = quesText
        self.questionNoText = questNoText
        self.correctAnswer = answerList[correctAnswerIndex]
        super.init(nibName: nil, bundle: nil)
        
        questionTrackerView = UIView()
        
        for index in 0...numOfQuestions-1 {
            progressArray.append(UIView())
            progressArray[index].backgroundColor = .white.withAlphaComponent(0.5)
            questionTrackerView.addSubview(progressArray[index])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        
        [button1, button2, button3, button4].forEach
        {$0.addTarget(self, action: #selector(answerPressed(sender:)), for: .touchUpInside)}
    }
    
    private func buildViews(){
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1).cgColor,
                                UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1).cgColor]
        
        appName = UILabel()
        appName.textColor = .white
        appName.text = "PopQuiz"
        appName.font = UIFont(name: "SourceSansPro-Black", size: 30)
        appName.textAlignment = .center
        appName.adjustsFontSizeToFitWidth = true
        
        questionNoLabel = UILabel()
        questionNoLabel.textColor = .white
        questionNoLabel.text = questionNoText
        questionNoLabel.font = UIFont(name: "SourceSansPro-Black", size: 20)
        questionNoLabel.textAlignment = .center
        questionNoLabel.adjustsFontSizeToFitWidth = true
        
        questionLabel = UILabel()
        questionLabel.textColor = .white
        questionLabel.text = questionText
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont(name: "SourceSansPro-Black", size: 25)
        questionLabel.textAlignment = .left
        
        button1 = RoundButton()
        button1.backgroundColor = .white.withAlphaComponent(0.3)
        button1.contentHorizontalAlignment = .left
        button1.clipsToBounds = true
        button1.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        button1.contentEdgeInsets.left = 20
        button1.contentEdgeInsets.top = 5
        button1.contentEdgeInsets.bottom = 5
        
        button2 = RoundButton()
        button2.backgroundColor = .white.withAlphaComponent(0.3)
        button2.contentHorizontalAlignment = .left
        button2.clipsToBounds = true
        button2.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        button2.contentEdgeInsets.left = 20
        button2.contentEdgeInsets.top = 5
        button2.contentEdgeInsets.bottom = 5

        button3 = RoundButton()
        button3.backgroundColor = .white.withAlphaComponent(0.3)
        button3.contentHorizontalAlignment = .left
        button3.clipsToBounds = true
        button3.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        button3.contentEdgeInsets.left = 20
        button3.contentEdgeInsets.top = 5
        button3.contentEdgeInsets.bottom = 5

        button4 = RoundButton()
        button4.contentHorizontalAlignment = .left
        button4.backgroundColor = .white.withAlphaComponent(0.3)
        button4.clipsToBounds = true
        button4.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        button4.titleLabel?.textColor = .white
        button4.contentEdgeInsets.left = 20
        button4.contentEdgeInsets.top = 5
        button4.contentEdgeInsets.bottom = 5
        
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
        
        progressArray[indexProgress].backgroundColor = .white

        view.layer.insertSublayer(layerGradient, at: 0)
        view.addSubview(appName)
        view.addSubview(questionLabel)
        view.addSubview(questionNoLabel)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(questionTrackerView)


    }
    
    private func addConstraints(){
        
        appName.snp.makeConstraints{make -> Void in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        questionLabel.snp.makeConstraints{make -> Void in
            make.top.equalTo(appName.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        button1.snp.makeConstraints{make -> Void in
            make.top.equalTo(questionLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        button2.snp.makeConstraints{make -> Void in
            make.top.equalTo(button1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        button3.snp.makeConstraints{make -> Void in
            make.top.equalTo(button2.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        button4.snp.makeConstraints{make -> Void in
            make.top.equalTo(button3.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        questionNoLabel.snp.makeConstraints{make -> Void in
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalToSuperview().dividedBy(9)
            make.centerX.equalToSuperview()
        }
        
        questionTrackerView.snp.makeConstraints{make -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(questionNoLabel.snp.top).offset(10)
        }
        
        progressArray[0].snp.makeConstraints{ make -> Void in
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(4)
            make.width.equalToSuperview().dividedBy(Double(progressArray.count)+0.5)
        }
        
        for index in 1...(numOfQuestions-1){
            progressArray[index].snp.makeConstraints{make -> Void in
                make.left.equalTo(progressArray[index - 1].snp.right).offset(5)
                make.width.equalToSuperview().dividedBy(Double(progressArray.count)+0.5)
                make.height.equalToSuperview()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
    
    @objc func answerPressed(sender: UIButton){
        let parentViewCont = self.parent as! QuizPageViewController
        
        if (sender.currentTitle == correctAnswer) {
            sender.backgroundColor = .green
            parentViewCont.goToNextPage(correct: true, index: indexProgress )

        }
        else{
            for button in [button4, button3, button2, button1] {
                if (button?.currentTitle == correctAnswer){
                    button?.backgroundColor = .green
                }
            }
            sender.backgroundColor = .red
            parentViewCont.goToNextPage(correct: false, index: indexProgress)
        }
    }
    
    func setProgress(index: Int){
        indexProgress = index
    }
    
    func setResult(index: Int, color: UIColor){
        progressArray[index].backgroundColor = color
    }
    
    
}
