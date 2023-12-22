//
//  CustomTabBarView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 30.08.2022.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @EnvironmentObject var tabBarVM: TabBarViewModel
    @Binding var selection: TabBarItem
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 30) {
                ForEach(tabBarVM.tabs, id: \.self) { tab in
                    tabView(tab: tab)
                        .onTapGesture { switchToTab(tab: tab)}
                }
            }
            .frame(maxWidth: .infinity)
            .padding(6)
            .background(
                Color.indigo.opacity(0.3).ignoresSafeArea(edges: .bottom)
            )
        }
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: selection == tab ? tab.selectedIcon : tab.deselectedIcon)
                .resizable()
                .frame(width: 22, height: 22)
            Text(tab.title)
                .font(.system(size: 10))
        }
        .padding(.horizontal, 30)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct TabBarItem: Hashable {
    let selectedIcon: String
    let deselectedIcon = "scale.3d"
    let title: String
}
