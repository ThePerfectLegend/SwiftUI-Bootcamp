//
//  Menu.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 28.04.2022.
//

import SwiftUI

struct MenuView: View {
    
    @State var greeting: Greetings = .short
    
    enum Greetings: String, Identifiable, CaseIterable {
        case short = "Hi"
        case medium = "Hello"
        case long = "Nice to see you"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Options", selection: $greeting) {
                ForEach(Greetings.allCases) { greeting in
                    Text(greeting.rawValue).tag(greeting)
                }
            }
            .pickerStyle(.segmented)
            Text("Greeting wrapped in menu:")
            Menu {
                Button("Send to Someone", action: {})
                Button("Save as PDF", action: {})
            } label: {
                Label(greeting.rawValue, systemImage: "doc.fill")
                    .labelStyle(.titleOnly)
            }
            
            Text("Greeting without menu:")
            Text(greeting.rawValue)
        }
    }
}

