//
//  QuizPageViewController.swift
//  QuizApp
//
//  Created by Luka Cicak on 03.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizPageViewController: UIPageViewController {
    
    private var controllers: [QuizViewController]!
    private var displayedIndex = 0
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let firstVC = controllers.first else { return }
        dataSource = self
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
    }
    
    func setControllers(controllerArray: [QuizViewController]){
        controllers = controllerArray
    }

}

extension QuizPageViewController: UIPageViewControllerDataSource{
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        displayedIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? QuizViewController,
              let controllerIndex = controllers.firstIndex(of: vc),
              controllerIndex + 1 < controllers.count
        
        else { return nil }
        
        displayedIndex = controllerIndex + 1
        return controllers[displayedIndex]
    }
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil, correct: Bool, index: Int) {
        
        if correct {
            score += 1
            for i in 0...controllers.count-1{
                controllers[i].setResult(index: index, color: .green)
            }
        }
        
        else{
            for i in 0...controllers.count-1{
                controllers[i].setResult(index: index, color: .red)
            }
        }
        
        if (displayedIndex == controllers.count - 1){
            let vc = QuizFinishedViewController(text: "\(score)/\(controllers.count)")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if (displayedIndex < controllers.count){
            if let currentViewController = controllers?[displayedIndex] {
                if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                    setViewControllers([nextPage], direction: .forward, animated: true, completion: completion)
                }
            }
        }
    }
}



