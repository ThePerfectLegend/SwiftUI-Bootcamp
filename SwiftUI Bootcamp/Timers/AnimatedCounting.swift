//
//  TimerBootcamp.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 15.07.2022.
//

import SwiftUI

struct AnimatedCounting: View {
    
    let timer = Timer.publish(every: 0.25, tolerance: nil, on: .main, in: .common).autoconnect()
    
    @State var count = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0 / 255, green: 150 / 255, blue: 225 / 255), Color(red: 0 / 255, green: 84 / 255, blue: 147 / 255)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
                Circle()
                    .offset(y: count == 4 ? -20 : 0)
                Circle()
                    .offset(y: count == 5 ? -20 : 0)
            }
            .foregroundColor(.white)
            .frame(width: 150)
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

