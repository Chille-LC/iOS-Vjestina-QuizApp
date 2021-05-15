//
//  QuizFinishedViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 05.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizFinishedViewController: UIViewController {
    
    private var score: UILabel!
    private var finishButton: RoundButton!
    private var layerGradient: CAGradientLayer!
    private var scoreText = ""
    private var quizFinishedPresenter = QuizFinishedPresenter()
    
    init(text: String) {
        scoreText = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        quizFinishedPresenter.sendResults(viewCont: self)
        super.viewDidLoad()
        buildViews()
        addConstraints()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        finishButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
    }
    
    private func buildViews(){
        layerGradient = CAGradientLayer()
        layerGradient.frame = view.bounds
        layerGradient.colors = [Colors.purple1.cgColor,
                                Colors.darkBlue.cgColor]
        
        score = UILabel()
        score.textColor = .white
        score.text = scoreText
        score.font = UIFont(name: "SourceSansPro-Black", size: 50)
        score.textAlignment = .center
        score.adjustsFontSizeToFitWidth = true
        
        finishButton = RoundButton()
        finishButton.backgroundColor = .white
        finishButton.setTitleColor(.purple, for: .normal)
        finishButton.setTitle("Finish Quiz", for: .normal)
        finishButton.clipsToBounds = true
        finishButton.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: 20)
        
        view.layer.addSublayer(layerGradient)
        view.addSubview(score)
        view.addSubview(finishButton)
    }
    
    private func addConstraints(){
        
        score.snp.makeConstraints{ make -> Void in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(7)
        }
        
        finishButton.snp.makeConstraints{ make -> Void in
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func finishQuiz(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layerGradient.frame = view.bounds
    }
}
