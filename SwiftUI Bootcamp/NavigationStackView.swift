//
//  NavigationStackView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 02.06.2024.
//

import SwiftUI

struct NavigationStackView: View {
    
    private let fruits = ["Apple", "Orange", "Waterlemon", "Pineapple", "Passion Fruit"]
    
    @State private var stackPath: [String] = []
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action: {
                        stackPath.append(contentsOf: [
                        "Coconut", "Mango", "Waterlemon"
                        ])
                    }) {
                        Text("Super segue")
                    }
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    Divider()
                    ForEach(0..<10) { value in
                        NavigationLink(value: value) {
                            Text("Click For Navigate To Screen \(value)")
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Navigation Stack")
            .navigationDestination(for: Int.self) { value in
                SecondScreenView(value: value)
            }
            .navigationDestination(for: String.self) { fruit in
                Text("Fruit Screen For \(fruit)")
            }
        }
    }
}

struct SecondScreenView: View {
    
    private let value: Int
    
    init(value: Int) {
        self.value = value
        print("SecondScreenView inited with \(value)")
    }
    
    var body: some View {
        Text("Screen \(value)")
    }
}

#Preview {
    NavigationStackView()
}


// MARK: NavigationStack vs NavigationView
// 1. NavigationStack has lazy loading by default
// 2. NavigationStack has option for navigation path for navigate to few screens forward
// 3. NavigationStack supporting from iOS 16
