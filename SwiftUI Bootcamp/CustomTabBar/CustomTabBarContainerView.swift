//
//  CustomTabBarContainerView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 30.08.2022.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    let content: Content
    
    @Binding var selection: TabBarItem
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(selection: $selection)
        }
    }
}

