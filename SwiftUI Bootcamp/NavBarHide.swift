//
//  NavBarHide.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 03.05.2022.
//

import SwiftUI
import UIKit


struct NavBarHide: View {
    var body: some View {
        NavigationView {
            TabView {
                First()
                        .badge(10)
                        .tabItem {
                            Image(systemName: "1.square.fill")
                            Text("First")
                        }
                    Text("Another Tab")
                        .tabItem {
                            Image(systemName: "2.square.fill")
                            Text("Second")
                        }
                    Text("The Last Tab")
                        .tabItem {
                            Image(systemName: "3.square.fill")
                            Text("Third")
                        }
            }
        }
    }
}

struct First: View {
    var body: some View {
        VStack {
            NavigationLink(destination: Second()) {
                Text("First View, tap to navigate")
                    .font(.headline)
            }
        }
        .navigationTitle("First title")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

struct Second: View {
    var body: some View {
        VStack {
            
                Text("Second View, no TabBar")
                    .font(.headline)
            
        }
        .navigationBarHidden(true)
        
    }
}



extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
