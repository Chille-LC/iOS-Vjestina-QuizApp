//
//  TableViewCell.swift
//  QuizApp
//
//  Created by Luka Cicak on 14.04.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizCell: UITableViewCell{
    
    private var quizImageView: UIImageView!
    private var quizTitle: UILabel!
    private var quizDescription: UILabel!
    private var levelImage: UIImageView!
    private var levelImage1: UIImageView!
    private var levelImage2: UIImageView!
    private var paddedView: UIView!
    private var thisQuiz: Quiz!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(quiz: Quiz){
        
        thisQuiz = quiz
        quizImageView.load(url: quiz.imageUrl)
        quizTitle.text = quiz.title
        quizDescription.text = quiz.description
        
        let activeImage = categoryImages[quiz.category.rawValue]!
        let InactiveImage = Images.greyRect
        
        
        switch quiz.level {
        case 2:
            levelImage.image = activeImage
            levelImage1.image = activeImage
            levelImage2.image = InactiveImage
            break
        case 3:
            levelImage.image = activeImage
            levelImage1.image = activeImage
            levelImage2.image = activeImage
            break
        default:
            levelImage.image = activeImage
            levelImage1.image = InactiveImage
            levelImage2.image = InactiveImage
        }
    }
    
    private func buildViews(){
        
        self.backgroundColor = UIColor.purple.withAlphaComponent(0)
        
        paddedView = UIView()
        paddedView.layer.cornerRadius = 10
        paddedView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        quizImageView = UIImageView()
        quizImageView.clipsToBounds = true
        quizImageView.layer.cornerRadius = 10
        
        quizTitle = UILabel()
        quizTitle.numberOfLines = 1
        quizTitle.adjustsFontSizeToFitWidth = true
        quizTitle.font = UIFont(name: "SourceSansPro-SemiBold", size: 30)
        quizTitle.textColor = .white
        
        quizDescription = UILabel()
        quizDescription.numberOfLines = 3
        quizDescription.adjustsFontSizeToFitWidth = true
        quizDescription.font = UIFont(name: "SourceSansPro-Light", size: 15)
        quizDescription.textColor = .white
        
        levelImage = UIImageView()
        levelImage.clipsToBounds = true
        
        levelImage1 = UIImageView()
        levelImage1.clipsToBounds = true
        
        levelImage2 = UIImageView()
        levelImage2.clipsToBounds = true
        
        paddedView.addSubview(quizImageView)
        paddedView.addSubview(quizTitle)
        paddedView.addSubview(quizDescription)
        paddedView.addSubview(levelImage2)
        paddedView.addSubview(levelImage1)
        paddedView.addSubview(levelImage)
        addSubview(paddedView)
        
    }
    
    private func addConstraints(){
        
        paddedView.snp.makeConstraints{ make -> Void in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        quizImageView.snp.makeConstraints{ make -> Void in
            make.centerY.equalTo(paddedView.snp.centerY)
            make.left.equalTo(paddedView.snp.left).offset(10)
            make.height.equalTo(paddedView.snp.height).multipliedBy(0.8)
            make.width.equalTo(quizImageView.snp.height).multipliedBy(1.5)
        }
        
        quizTitle.snp.makeConstraints{ make -> Void in
            make.left.equalTo(quizImageView.snp.right).offset(10)
            make.top.equalTo(paddedView.snp.top).offset(15)
            make.height.equalTo(quizImageView.snp.height).multipliedBy(0.45)
            make.right.equalTo(paddedView.snp.right).offset(-5)
        }
        
        quizDescription.snp.makeConstraints{ make -> Void in
            make.left.equalTo(quizImageView.snp.right).offset(10)
            make.top.equalTo(quizTitle.snp.bottom).offset(5)
            make.right.equalTo(paddedView.snp.right).offset(-5)
        }
        
        levelImage2.snp.makeConstraints{ make -> Void in
            make.right.equalTo(paddedView.snp.right).offset(-10)
            make.top.equalTo(paddedView.snp.top).offset(10)
        }
        
        levelImage1.snp.makeConstraints{ make -> Void in
            make.right.equalTo(levelImage2.snp.left).offset(-3)
            make.top.equalTo(levelImage2)
        }
        
        levelImage.snp.makeConstraints{ make -> Void in
            make.top.equalTo(levelImage2)
            make.right.equalTo(levelImage1.snp.left).offset(-3)
        }
    }
    
    func getQuiz() -> Quiz{
        return thisQuiz
    }
    
}

extension UIImageView {
    func load(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}


