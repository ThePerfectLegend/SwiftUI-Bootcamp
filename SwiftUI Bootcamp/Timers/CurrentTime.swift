//
//  CurrentTime.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI

struct CurrentTime: View {
    
    let timer = Timer.publish(every: 1.0, tolerance: nil, on: .main, in: .common).autoconnect()
    
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0 / 255, green: 150 / 255, blue: 225 / 255), Color(red: 0 / 255, green: 84 / 255, blue: 147 / 255)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            Text("\(currentDate)")
                .font(.system(size: 75, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { value in
            currentDate = value
        }
    }
}
