//
//  SearchController.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation
import UIKit
import SnapKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuizzesPresenterDelegate{
    
    func showSuccessPopup() {
        if configured == 0 {
            configurTableView()
            configured = 1
        }
        else {
            tableView.reloadData()
        }
    }
    
    private var searchBar: TextFieldWithPadding!
    private var searchButton: UIButton!
    private var tableView = UITableView()
    private var layerGradient: CAGradientLayer!
    private var searchPresenter: SearchPresenter!
    private var configured = 0
    
    struct Cells {
        static let cellID = "quizCell"
    }
    
    init() {
        self.searchPresenter = SearchPresenter()
        super.init(nibName: nil, bundle: nil)
        searchPresenter.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        searchBar.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    private func buildViews(){
        
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [Colors.purple1.cgColor,
                                Colors.darkBlue.cgColor]
        
        searchBar = TextFieldWithPadding()
        searchBar.font = UIFont(name: "SourceSansPro-Black", size: 15)
        searchBar.textColor = .white
        searchBar.backgroundColor = .white.withAlphaComponent(0.3)
        searchBar.placeholder = "Search"
        
        searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 15)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .none
        searchButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        view.layer.addSublayer(layerGradient)
        view.addSubview(searchButton)
        view.addSubview(searchBar)
    }
    
    private func addConstraints(){
        
        searchBar.snp.makeConstraints{make -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.left.equalToSuperview().offset(10)
        }
        
        searchButton.snp.makeConstraints{make -> Void in
            make.top.equalTo(searchBar.snp.top)
            make.height.equalTo(searchBar.snp.height)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalTo(searchBar.snp.right).offset(5)
        }
    }
    
    func configurTableView(){
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.frame.height / 5.5
        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCell.self, forCellReuseIdentifier: Cells.cellID)
        
        tableView.snp.makeConstraints{make -> Void in
            make.bottom.equalToSuperview().offset(15)
            make.right.left.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
    }
    
    
    //tableView metode
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPresenter.getQuizzes()[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchPresenter.getQuizzes().count
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
        layerGradient2.colors = [Colors.purple1.cgColor, Colors.darkBlue.cgColor]
        
        label.text = searchPresenter.getHeaderText(section: section)
        label.textColor = searchPresenter.getHeaderColor(section: section)
        
        label.layer.addSublayer(layerGradient2)
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellID) as! QuizCell
        let quiz = searchPresenter.getQuizzes()[indexPath.section][indexPath.row]
        cell.set(quiz: quiz)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuizCell
        let newQuizPage = searchPresenter.createQuizPageController(quiz: cell.getQuiz())
        UserDefaults.standard.setValue(cell.getQuiz().id, forKey: "quiz_id")
        self.navigationController?.pushViewController(newQuizPage, animated: true)
    }
    
    @objc func editingChanged(_ textField: UITextField){
        searchPresenter.fetchQuizzes(text: textField.text ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
}
