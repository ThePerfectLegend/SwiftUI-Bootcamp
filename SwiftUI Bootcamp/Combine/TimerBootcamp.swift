//
//  TimerBootcamp.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 15.07.2022.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 2.5, tolerance: nil, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
     @State var currentDate: Date = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.dateStyle = .none
     formatter.timeStyle = .medium
     return formatter
     }
     */
    
    
    // Countdown
    /*
     @State var count = 10
     @State var finishText: String?
     */
    
    // Countdown to date
    /*
     @State var timeRemaining = ""
     let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     
     func updateTime() {
     let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate) // Difference between two dates
     let hour = remaining.hour ?? 0
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timeRemaining = "\(hour):\(minute):\(second)"
     }
     */
    
    // Animation counter
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
            
            // MARK: Animation counter
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .foregroundColor(.white)
//            .frame(width: 150)
            
            // MARK: Current time, Countdown, Countdown to date
            //            Text(timeRemaining)
            //                .font(.system(size: 75, weight: .semibold, design: .rounded))
            //                .foregroundColor(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
        }
        // Current time
        //        .onReceive(timer) { value in
        //            currentDate = value
        //        }
        
        // CountDown
        //        .onReceive(timer) { _ in
        //            if count < 1 {
        //                finishText = "Done"
        //            } else {
        //                count -= 1
        //            }
        //        }
        // Countdown to date
        //        .onReceive(timer) { _ in
        //            updateTime()
        //        }
        // Animation counter
//        .onReceive(timer) { _ in
//            withAnimation(.easeInOut(duration: 0.5)) {
//                count = count == 3 ? 0 : count + 1
//            }
//        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 3 ? 1 : count + 1
            }
        }
    }
}

