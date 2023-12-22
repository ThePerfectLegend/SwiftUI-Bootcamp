//
//  PillReminderTabBar.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 01.09.2022.
//

import SwiftUI

struct PillReminderTabBarView: View {
    
    let tabs: [PillReminderTabBarItem] = [
        .init(title: "Add", selectedIcon: "plus.circle.fill", inactiveIcon: "plus.circle"),
        .init(title: "Today", selectedIcon: "calendar.circle.fill", inactiveIcon: "calendar.circle"),
        .init(title: "More", selectedIcon: "ellipsis.circle.fill", inactiveIcon: "ellipsis.circle")
    ]
    
    @State var selectetTab = PillReminderTabBarItem(title: "Add", selectedIcon: "plus.circle.fill", inactiveIcon: "plus.circle")
    
    var body: some View {
        VStack {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    tabView(tab: tab)
                        .onTapGesture {switchToTab(tab: tab)}
                }
                .padding(.horizontal, 30)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.cyan.opacity(0.2))
        .ignoresSafeArea(edges: .bottom)
        .border(Color.red)
    }
}


extension PillReminderTabBarView {
    private func tabView(tab: PillReminderTabBarItem) -> some View {
        VStack {
            Image(systemName: selectetTab == tab ? tab.selectedIcon : tab.inactiveIcon)
                .resizable()
                .frame(width: 24, height: 24)
            Text(tab.title)
                .font(.system(size: 10))
                .foregroundColor(selectetTab == tab ? .green : .secondary)
        }
        .padding(.horizontal, 12)
        .padding(.top, 9)
        .border(Color.red)
    }
    
    private func switchToTab(tab: PillReminderTabBarItem) {
        withAnimation(.easeInOut) {
            selectetTab = tab
        }
    }
}

struct PillReminderTabBarItem: Hashable {
    let title: String
    let selectedIcon: String
    let inactiveIcon: String
}
