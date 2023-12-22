//
//  AppTabBarView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 01.09.2022.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection = "Home"
    
    var body: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.green
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

