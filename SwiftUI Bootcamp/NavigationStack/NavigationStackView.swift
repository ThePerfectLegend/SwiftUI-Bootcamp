//
//  NavigationStackView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 02.06.2024.
//

import SwiftUI

struct NavigationStackView: View {
    
    private let fruits = ["Apple", "Orange", "Waterlemon", "Pineapple", "Passion Fruit"]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action: {
                        guard let element = fruits.randomElement() else { return }
                        path.append(element)
                    }) {
                        Text("Super segue")
                    }
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    Divider()
                    ForEach(0..<5) { value in
                        NavigationLink(value: value) {
                            Text("Click For Navigate To Screen \(value)")
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Navigation Stack")
            .navigationDestination(for: Int.self) { value in
                Text("Value Screen For \(value)")
            }
            .navigationDestination(for: String.self) { fruit in
                Text("Fruit Screen For \(fruit)")
            }
        }
    }
}

#Preview {
    NavigationStackView()
}


// MARK: NavigationStack vs NavigationView
// 1. NavigationStack has lazy loading by default
// 2. NavigationStack(path:) allows managing a navigation path with support for different data types and navigating multiple screens forward
// 3. NavigationStack is supported from iOS 16 and later
// 4. NavigationStack supports serialization of the navigation path, allowing to save and restore user screen state between sessions
// 5. NavigationStack is more integrated with modern SwiftUI APIs
// 6. NavigationView supports older iOS versions (iOS 13 and later)
// 7. NavigationView is simpler for basic navigation but less flexible and powerful compared to NavigationStack
