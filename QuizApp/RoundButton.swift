//
//  RoundButton.swift
//  QuizApp
//
//  Created by Luka Cicak on 14.04.2021..
//

import Foundation
import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }
}

