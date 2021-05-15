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
    
    private var quizzesPresenter =  QuizzesPresenter()
    private var QuizTableView = UITableView()


    struct Cells {
        static let cellID = "quizCell"
    }
   
    
    override func viewDidLoad() {

        super.viewDidLoad()
        quizzesPresenter.fetchQuizzes(viewController: self)
        buildViews()
        addConstraints()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
       
        getButton.addTarget(self, action: #selector(getButtonIsPressed), for: .touchUpInside)
        
    }
    
    private func buildViews(){
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [Colors.purple1.cgColor,
                                Colors.darkBlue.cgColor]
        
        appName = UILabel()
        appName.textColor = .white
        appName.text = "PopQuiz"
        appName.font = UIFont(name: "SourceSansPro-Black", size: 38)
        appName.textAlignment = .center
        appName.adjustsFontSizeToFitWidth = true
        
        getButton = RoundButton()
        getButton.setTitle("Get Quiz", for: .normal)
        getButton.backgroundColor = .white
        getButton.clipsToBounds = true
        getButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        getButton.setTitleColor(Colors.purple2, for: .normal)
        
        errorScreen = UIView()
        
        labelError = UILabel()
        labelError.text = "Error"
        labelError.font = UIFont(name: "SourceSansPro-Black", size: 35)
        labelError.textColor = .white
        labelError.textAlignment = .center
        
        labelMessage = UILabel()
        labelMessage.text = "Data can’t be reached. Please try again"
        labelMessage.textColor = .white
        labelMessage.font = UIFont(name: "SourceSansPro-Light", size: 18)
        labelMessage.numberOfLines = 2
        labelMessage.textAlignment = .center
        labelMessage.adjustsFontSizeToFitWidth = true
        
        errorImage = UIImageView(image: UIImage(systemName: "xmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        
        errorScreen.addSubview(labelMessage)
        errorScreen.addSubview(labelError)
        errorScreen.addSubview(errorImage)
        
        funScreen = UIView()
        
        labelFunFact = UILabel()
        labelFunFact.text = "💡Fun Fact"
        labelFunFact.font = UIFont(name: "SourceSansPro-SemiBold", size: 30)
        labelFunFact.textColor = .white
        labelFunFact.textAlignment = .left
        
        labelFact = UILabel()
        labelFact.numberOfLines = 2
        labelFact.textColor = .white
        labelFact.font = UIFont(name: "SourceSansPro-Light", size: 22)
        labelFact.textAlignment = .left
        labelFact.adjustsFontSizeToFitWidth = true
        
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
        
        QuizTableView.isHidden = true
        view.addSubview(QuizTableView)
        
        QuizTableView.delegate = self
        QuizTableView.dataSource = self
        QuizTableView.rowHeight = view.frame.height / 5.5
        QuizTableView.backgroundColor = .none
        QuizTableView.translatesAutoresizingMaskIntoConstraints = false
        QuizTableView.register(QuizCell.self, forCellReuseIdentifier: Cells.cellID)
        
        QuizTableView.snp.makeConstraints{make -> Void in
            make.bottom.equalToSuperview().offset(10)
            make.right.left.equalToSuperview()
            make.top.equalTo(funScreen.snp.bottom)
        }
    }
    
    
    //tableView metode
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesPresenter.getQuizzes()[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesPresenter.getQuizzes().count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = QuizTableView.indexPathForSelectedRow {
            QuizTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 25)
        
        let layerGradient2 = CAGradientLayer()
        layerGradient2.frame = label.bounds
        layerGradient2.colors = [Colors.purple1.cgColor, Colors.darkBlue.cgColor]
        
        label.text = quizzesPresenter.getHeaderText(section: section)
        label.textColor = quizzesPresenter.getHeaderColor(section: section)
        
        label.layer.addSublayer(layerGradient2)
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellID) as! QuizCell
        let quiz = quizzesPresenter.getQuizzes()[indexPath.section][indexPath.row]
        cell.set(quiz: quiz)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuizCell
        let newQuizPage = quizzesPresenter.createQuizPageController(quiz: cell.getQuiz())
        UserDefaults.standard.setValue(cell.getQuiz().id, forKey: "quiz_id")
        self.navigationController?.pushViewController(newQuizPage, animated: true)
    }
    
    @objc func getButtonIsPressed(){
        QuizTableView.reloadData()
        errorScreen.isHidden = true
        funScreen.isHidden = false
        QuizTableView.isHidden = false
        
        labelFact.text = quizzesPresenter.getFact()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
    
}






