//
//  TableViewCell.swift
//  QuizApp
//
//  Created by Luka Cicak on 14.04.2021..
//

import Foundation
import UIKit

class QuizCell: UITableViewCell{
    
    private var quizImageView: UIImageView!
    private var quizTitle: UILabel!
    private var quizDescription: UILabel!
    private var levelImage: UIImageView!
    private var levelImage1: UIImageView!
    private var levelImage2: UIImageView!
    private var paddedView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(quiz: Quiz){
        quizImageView.load(url: URL(string: quiz.imageUrl)!)
        quizTitle.text = quiz.title
        quizDescription.text = quiz.description
        let activeImage: UIImage!
        let notActiveImage = Images.greyRect
        
        if quiz.category.rawValue == "SCIENCE"{
            activeImage = Images.blueRect
        }
        else{
            activeImage = Images.yellowRect
        }
        
        if quiz.level == 1{
            levelImage.image = activeImage
            levelImage1.image = notActiveImage
            levelImage2.image = notActiveImage
        }
        else if quiz.level == 2{
            levelImage.image = activeImage
            levelImage1.image = activeImage
            levelImage2.image = notActiveImage
        }
        else if quiz.level == 3{
            levelImage.image = activeImage
            levelImage1.image = activeImage
            levelImage2.image = activeImage
        }
        
    }
    
    private func buildViews(){
        
        self.backgroundColor = UIColor.purple.withAlphaComponent(0)
        
        paddedView = UIView()
        paddedView.translatesAutoresizingMaskIntoConstraints = false
        paddedView.layer.cornerRadius = 10
        paddedView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        quizImageView = UIImageView()
        quizImageView.clipsToBounds = true
        quizImageView.layer.cornerRadius = 10
        quizImageView.translatesAutoresizingMaskIntoConstraints = false
        
        quizTitle = UILabel()
        quizTitle.numberOfLines = 1
        quizTitle.adjustsFontSizeToFitWidth = true
        quizTitle.translatesAutoresizingMaskIntoConstraints = false
        quizTitle.font = UIFont(name: "SourceSansPro-SemiBold", size: 30)
        quizTitle.textColor = .white
        
        quizDescription = UILabel()
        quizDescription.numberOfLines = 3
        quizDescription.adjustsFontSizeToFitWidth = true
        quizDescription.translatesAutoresizingMaskIntoConstraints = false
        quizDescription.font = UIFont(name: "SourceSansPro-Light", size: 15)
        quizDescription.textColor = .white
        
        levelImage = UIImageView()
        levelImage.clipsToBounds = true
        levelImage.translatesAutoresizingMaskIntoConstraints = false
        
        levelImage1 = UIImageView()
        levelImage1.clipsToBounds = true
        levelImage1.translatesAutoresizingMaskIntoConstraints = false
        
        levelImage2 = UIImageView()
        levelImage2.clipsToBounds = true
        levelImage2.translatesAutoresizingMaskIntoConstraints = false
        
        paddedView.addSubview(quizImageView)
        paddedView.addSubview(quizTitle)
        paddedView.addSubview(quizDescription)
        paddedView.addSubview(levelImage2)
        paddedView.addSubview(levelImage1)
        paddedView.addSubview(levelImage)
        addSubview(paddedView)
        
    }
    
    private func addConstraints(){
        
        paddedView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        paddedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        paddedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        paddedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
                
        quizImageView.centerYAnchor.constraint(equalTo: paddedView.centerYAnchor).isActive = true
        quizImageView.leadingAnchor.constraint(equalTo: paddedView.leadingAnchor, constant: 10).isActive = true
        quizImageView.heightAnchor.constraint(equalTo: paddedView.heightAnchor, multiplier: 0.8).isActive = true
        quizImageView.widthAnchor.constraint(equalTo: quizImageView.heightAnchor, multiplier: 1.5).isActive = true
        
        quizTitle.leadingAnchor.constraint(equalTo: quizImageView.trailingAnchor, constant: 10).isActive = true
        quizTitle.topAnchor.constraint(equalTo: paddedView.topAnchor, constant: 15).isActive = true
        quizTitle.heightAnchor.constraint(equalTo: quizImageView.heightAnchor, multiplier: 0.45).isActive = true
        quizTitle.widthAnchor.constraint(equalTo: quizImageView.widthAnchor, multiplier: 1.3).isActive = true
        
        quizDescription.leadingAnchor.constraint(equalTo: quizImageView.trailingAnchor, constant: 10).isActive = true
        quizDescription.topAnchor.constraint(equalTo: quizTitle.bottomAnchor, constant: 5).isActive = true
        
        levelImage2.trailingAnchor.constraint(equalTo: paddedView.trailingAnchor, constant: -10).isActive = true
        levelImage2.topAnchor.constraint(equalTo: paddedView.topAnchor, constant: 10).isActive = true
        
        levelImage1.trailingAnchor.constraint(equalTo: levelImage2.leadingAnchor, constant: -3).isActive = true
        levelImage1.topAnchor.constraint(equalTo: levelImage2.topAnchor).isActive = true
        
        levelImage.trailingAnchor.constraint(equalTo: levelImage1.leadingAnchor, constant: -3).isActive = true
        levelImage.topAnchor.constraint(equalTo: levelImage2.topAnchor).isActive = true
    }
    

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
