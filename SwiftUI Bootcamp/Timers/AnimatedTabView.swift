//
//  AnimatedTabView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI

struct AnimatedTabView: View {
    let timer = Timer.publish(every: 2.5, tolerance: nil, on: .main, in: .common).autoconnect()
    
    @State var count = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0 / 255, green: 150 / 255, blue: 225 / 255), Color(red: 0 / 255, green: 84 / 255, blue: 147 / 255)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 3 ? 1 : count + 1
            }
        }
    }
}

