//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 13.04.2021..
//

import Foundation
import SnapKit
import UIKit


class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let DatServ = DataService()
    
    private var layerGradient: CAGradientLayer!
    private var appName: UILabel!
    private var funFact: UILabel!
    private var getButton: RoundButton!
    
    private var errorScreen: UIView!
    private var labelError: UILabel!
    private var labelMessage: UILabel!
    private var errorImage: UIImageView!
    
    private var funScreen: UIView!
    private var labelFunFact: UILabel!
    private var labelFact: UILabel!
    
    private var tableView = UITableView()
    private var quizzes: [Quiz] = []
    private var sectionedQuizzes = [[Quiz]]()
    private var noOfNBA = 0
    
    struct Cells {
        static let cellID = "quizCell"
    }
   
    
    override func viewDidLoad() {
        quizzes = DatServ.fetchQuizes()
        noOfNBA = quizzes.flatMap({$0.questions}).filter({$0.question.contains("NBA")}).count

        super.viewDidLoad()
        buildViews()
        addConstraints()
        configurTableView()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
       
        let sportsQuizzes = quizzes.filter({ $0.category.rawValue == "SPORTS"})
        let scienceQuizzes = quizzes.filter({ $0.category.rawValue == "SCIENCE"})
        
        sectionedQuizzes = [
            sportsQuizzes,
            scienceQuizzes
        ]
        
        getButton.addTarget(self, action: #selector(getButtonIsPressed), for: .touchUpInside)
    }
    
    private func buildViews(){
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1).cgColor,
                                UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1).cgColor]
        
        appName = UILabel()
        appName.textColor = .white
        appName.text = "PopQuiz"
        appName.font = UIFont(name: "SourceSansPro-Black", size: 38)
        appName.textAlignment = .center
        appName.adjustsFontSizeToFitWidth = true
        appName.translatesAutoresizingMaskIntoConstraints = false
        
        getButton = RoundButton()
        getButton.setTitle("Get Quiz", for: .normal)
        getButton.backgroundColor = .white
        getButton.clipsToBounds = true
        getButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        getButton.setTitleColor(UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 1), for: .normal)
        getButton.translatesAutoresizingMaskIntoConstraints = false
        
        errorScreen = UIView()
        errorScreen.translatesAutoresizingMaskIntoConstraints = false
        
        labelError = UILabel()
        labelError.text = "Error"
        labelError.font = UIFont(name: "SourceSansPro-Black", size: 35)
        labelError.textColor = .white
        labelError.textAlignment = .center
        labelError.translatesAutoresizingMaskIntoConstraints = false
        
        labelMessage = UILabel()
        labelMessage.text = "Data can’t be reached. Please try again"
        labelMessage.textColor = .white
        labelMessage.font = UIFont(name: "SourceSansPro-Light", size: 18)
        labelMessage.numberOfLines = 2
        labelMessage.textAlignment = .center
        labelMessage.adjustsFontSizeToFitWidth = true
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        
        errorImage = UIImageView(image: UIImage(systemName: "xmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        
        errorScreen.addSubview(labelMessage)
        errorScreen.addSubview(labelError)
        errorScreen.addSubview(errorImage)
        
        funScreen = UIView()
        funScreen.translatesAutoresizingMaskIntoConstraints = false
        
        labelFunFact = UILabel()
        labelFunFact.text = "💡Fun Fact"
        labelFunFact.font = UIFont(name: "SourceSansPro-SemiBold", size: 30)
        labelFunFact.textColor = .white
        labelFunFact.textAlignment = .left
        labelFunFact.translatesAutoresizingMaskIntoConstraints = false
        
        labelFact = UILabel()
        labelFact.text = "There are" + " \(noOfNBA) " + "questions that contain the word \"NBA\" "
        labelFact.numberOfLines = 2
        labelFact.textColor = .white
        labelFact.font = UIFont(name: "SourceSansPro-Light", size: 22)
        labelFact.textAlignment = .left
        labelFact.adjustsFontSizeToFitWidth = true
        labelFact.translatesAutoresizingMaskIntoConstraints = false
        
        funScreen.addSubview(labelFunFact)
        funScreen.addSubview(labelFact)
        funScreen.isHidden = true
                        
        view.layer.insertSublayer(layerGradient, at: 0)
        view.addSubview(appName)
        view.addSubview(getButton)
        view.addSubview(errorScreen)
        view.addSubview(funScreen)
        
    }
    
    private func addConstraints(){
        
        appName.snp.makeConstraints{make -> Void in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        getButton.snp.makeConstraints{make -> Void in
            make.top.equalTo(appName.snp.bottom).offset(30)
            make.width.equalTo(appName).multipliedBy(1.72)
            make.height.equalTo(appName).multipliedBy(0.95)
            make.centerX.equalToSuperview()
        }
        
        errorScreen.snp.makeConstraints{make -> Void in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        labelError.snp.makeConstraints{make -> Void in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        labelMessage.snp.makeConstraints{make -> Void in
            make.top.equalTo(labelError.snp.bottom).offset(10)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview()
        }
        
        errorImage.snp.makeConstraints{make -> Void in
            make.bottom.equalTo(labelError.snp.top).offset(-10)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(errorImage.snp.height)
            make.centerX.equalToSuperview()
        }
        
        funScreen.snp.makeConstraints{make -> Void in
            make.top.equalTo(getButton.snp.bottom).offset(20)
            make.height.equalTo(getButton).multipliedBy(2)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        labelFunFact.snp.makeConstraints{make -> Void in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.left.equalTo(view).offset(10)
        }
        
        labelFact.snp.makeConstraints{make -> Void in
            make.top.equalTo(labelFunFact.snp.bottom).offset(5)
            make.left.equalTo(labelFunFact).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configurTableView(){
        tableView.isHidden = true
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.backgroundColor = .none
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCell.self, forCellReuseIdentifier: Cells.cellID)
        
        tableView.snp.makeConstraints{make -> Void in
            make.bottom.equalToSuperview().offset(10)
            make.right.left.equalToSuperview()
            make.top.equalTo(funScreen.snp.bottom)
        }
    }
    
    
    
    
    //tableView metode
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedQuizzes[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedQuizzes.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        
        
        let layerGradient2 = CAGradientLayer()
        layerGradient2.frame = label.bounds
        layerGradient2.colors = [UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1).cgColor,
                                UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1).cgColor]
        
        if section == 0{
            label.textColor = UIColor(red: 0.95, green: 0.79, blue: 0.30, alpha: 1.00)
            label.text = "  Sports"
        }
        else{
            label.text = "  Science"
            label.textColor = UIColor(red: 0.34, green: 0.80, blue: 0.95, alpha: 1.00)
        }
        
        label.layer.addSublayer(layerGradient2)
        return label    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellID) as! QuizCell
        let quiz = sectionedQuizzes[indexPath.section][indexPath.row]
        
        cell.set(quiz: quiz)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuizCell
        let quiz = cell.getQuiz()
        let newQuizPage = QuizPageViewController()
        var controllers: [QuizViewController] = []
        var index = 1
        
        for question in quiz.questions {
            let qNumber = "\(index) of \(quiz.questions.count)"
            let vc = QuizViewController(answerList: question.answers, quesText: question.question, questNoText: qNumber, correctAnswerIndex: question.correctAnswer, numberOfQuestions: quiz.questions.count)
            
            index += 1
            controllers.append(vc)
        }
        
        for index in 0...controllers.count-1{
            controllers[index].setProgress(index: index)
        }
        
        newQuizPage.setControllers(controllerArray: controllers)
        self.navigationController?.pushViewController(newQuizPage, animated: true)
        
    }
    
    @objc func getButtonIsPressed(){
        errorScreen.isHidden = true
        funScreen.isHidden = false
        tableView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
    
}






