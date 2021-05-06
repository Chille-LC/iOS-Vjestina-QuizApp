//
//  TabBarController.swift
//  QuizApp
//
//  Created by Luka Cicak on 02.05.2021..
//

import Foundation
import UIKit

func createTabBarViewController() -> UIViewController {
    let vc = UITabBarController()
    
    vc.tabBar.tintColor = .purple
    vc.tabBar.barTintColor = .white
    vc.navigationItem.setHidesBackButton(true, animated: true)

    let quizImage = UIImage(systemName: "stopwatch")!
    
    let search = UIImage(systemName: "magnifyingglass")
    
    let gear = UIImage(systemName: "gearshape.fill")
    
    let mn = QuizzesViewController()
    mn.tabBarItem = UITabBarItem(title: "Quiz",
                                 image: quizImage,
                                 selectedImage: quizImage)
    
    
    let dm1 = DummyViewController2()
    dm1.tabBarItem = UITabBarItem(title: "Search",
                                  image: search,
                                  selectedImage: search)
    
    let dm2 = SettingsViewController()
    dm2.tabBarItem = UITabBarItem(title: "Settings",
                                  image: gear,
                                  selectedImage: gear)
    
    vc.viewControllers = [mn, dm1, dm2]
    
    return vc
}
