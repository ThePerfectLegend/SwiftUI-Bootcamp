//
//  Countdown.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI

struct Countdown: View {
    
    let timer = Timer.publish(every: 0.5, tolerance: nil, on: .main, in: .common).autoconnect()
    
    @State var count = 10
    @State var finishText: String?
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(red: 0 / 255, green: 150 / 255, blue: 225 / 255), Color(red: 0 / 255, green: 84 / 255, blue: 147 / 255)]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            
            Text(finishText ?? "\(count)")
                .font(.system(size: 75, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            if count < 1 {
                finishText = "Done!"
            } else {
                count -= 1
            }
        }
    }
}
