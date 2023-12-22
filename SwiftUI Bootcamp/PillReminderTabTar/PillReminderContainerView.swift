//
//  PillReminderContainerView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 01.09.2022.
//

import SwiftUI


//TabView<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View

struct PillReminderContainerView<Content: View>: View {
    
    @Binding var selection: PillReminderTabBarItem
    let content: Content
    
    init(selection: Binding<PillReminderTabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

