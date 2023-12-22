//
//  SwiftUI_BootcampApp.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 05.04.2022.
//

import SwiftUI

@main
struct SwiftUI_BootcampApp: App {
    
//    @StateObject var tabBarVM = TabBarViewModel()
//    @State var selection = TabBarItem(selectedIcon: "house", title: "Home")
    
    var body: some Scene {
        WindowGroup {
            CountdownToDate()
        }
    }
}
