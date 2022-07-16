//
//  TimerExamples.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI

struct TimerExamples: View {
    var body: some View {
        TabView {
            Countdown()
                .tabItem {
                    Label {
                        Text("Countdown")
                    } icon: {
                        Image(systemName: "timer")
                    }

                }
            CurrentTime()
                .tabItem {
                    Label {
                        Text("Current Time")
                    } icon: {
                        Image(systemName: "clock")
                    }

                }
            CountdownToDate()
                .tabItem {
                    Label {
                        Text("Countdown To Date")
                    } icon: {
                        Image(systemName: "calendar")
                    }

                }
            AnimatedCounting()
                .tabItem {
                    Label {
                        Text("Animated Counting")
                    } icon: {
                        Image(systemName: "livephoto")
                    }
                }
            AnimatedTabView()
                .tabItem {
                    Label {
                        Text("Animated TabView")
                    } icon: {
                        Image(systemName: "arrow.right.to.line")
                    }
                }
        }
    }
}

