//
//  TabBarViewModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 30.08.2022.
//

import Foundation

class TabBarViewModel: ObservableObject {
    @Published var tabs: [TabBarItem] = [
        .init(selectedIcon: "house", title: "Home"),
        .init(selectedIcon: "calendar", title: "Calendar"),
        .init(selectedIcon: "heart", title: "Favorites")
    ]
}
