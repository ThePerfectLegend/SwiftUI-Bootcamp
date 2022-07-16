//
//  CountdownToDate.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI

struct CountdownToDate: View {
    
    let timer = Timer.publish(every: 1.0, tolerance: nil, on: .main, in: .common).autoconnect()
    
    @State var timeRemaining = ""
    let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTime() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate) // Difference between two dates
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0 / 255, green: 150 / 255, blue: 225 / 255), Color(red: 0 / 255, green: 84 / 255, blue: 147 / 255)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            Text(timeRemaining)
                .font(.system(size: 75, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            updateTime()
        }
    }
}
