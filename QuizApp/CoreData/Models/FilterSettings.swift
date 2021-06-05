//
//  FilterSettings.swift
//  QuizApp
//
//  Created by Luka Cicak on 30.05.2021..
//

import Foundation

struct FilterSettings {

    let searchText: String?

    init(searchText: String? = nil) {
        self.searchText = (searchText?.isEmpty ?? true) ? nil : searchText
    }

}
