//
//  ContentView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 05.04.2022.
//

import SwiftUI

final class TabBarManager: ObservableObject {
    @Published var showTabBar = true
}

struct FirstView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination:
                                Text("Testing")
                                .edgesIgnoringSafeArea(.bottom)
                ) {
                    Text("Second View, tap to navigate")
            }
            }
            .navigationTitle("First title")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.yellow)
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ThirdView()) {
                Text("Second View, tap to navigate")
                    .font(.headline)
            }
        }
        .navigationTitle("Second title")
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.orange)
    }
}

struct ThirdView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: Text("Fouth view")) {
                Text("Third View with tabBar hidden")
                    .font(.headline)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct TabBarView: View {
    enum Tab: Int {
        case first, second, third
    }
    
    @EnvironmentObject var TBManager: TabBarManager
    
    @State private var selectedTab = Tab.first
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .first:
                    VStack(spacing: 0) {
                        FirstView()
                        tabBarView
                    }
                case .second:
                    NavigationView {
                        VStack(spacing: 0) {
                            SecondView()
                            tabBarView
                        }
                    }
                case .third:
                    ThirdView()
                }
            }
//            ZStack {
//                if selectedTab == .first {
//                    FirstView()
//                }
//                else if selectedTab == .second {
//                    NavigationView {
//                        VStack(spacing: 0) {
//                            SecondView()
//                            tabBarView
//                        }
//                    }
//                }
//            }
//            .animation(nil)
//
//            if selectedTab != .second {
//                tabBarView
//            }
        }
    }
    
    var tabBarView: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack(spacing: 20) {
                tabBarItem(.first, title: "First", icon: "hare", selectedIcon: "hare.fill")
                tabBarItem(.second, title: "Second", icon: "tortoise", selectedIcon: "tortoise.fill")
            }
            .padding(.top, 8)
        }
        .frame(height: 50)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    func tabBarItem(_ tab: Tab, title: String, icon: String, selectedIcon: String) -> some View {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 3) {
                    VStack {
                        Image(systemName: (selectedTab == tab ? selectedIcon : icon))
                            .font(.system(size: 24))
                            .foregroundColor(selectedTab == tab ? .primary : .black)
                    }
                    .frame(width: 55, height: 28)
                    
                    Text(title)
                        .font(.system(size: 11))
                        .foregroundColor(selectedTab == tab ? .primary : .black)
                }
            }
            .frame(width: 65, height: 42)
            .onTapGesture {
                selectedTab = tab
            }
        }
    }









//struct ContentView: View {
//    @State var tabSelection: Tabs = .tab1
//    var body: some View {
//        NavigationView{
//            TabView(selection: $tabSelection){
////                NavigationView{ //if you write the NavigationView here, you cannot remove TabBar after navigation
//                    NavigationLink(destination: NavigatedView()){
//                        VStack{
//                            Text("Here is Tab 1")
//                            Text("Tap me to NavigatedView")
//                        }
////                        .navigationBarTitle("Tab1")//NavigationBarTitle does not work here
//                    }
////                }
//                    .tabItem { Text("Tab 1") }
//                .tag(Tabs.tab1)
//
////                NavigationView{//Tab2 also has a NavigationView
//                    NavigationLink(destination: NavigatedView()){
//                        VStack{
//                            Text("Here is Tab 2")
//                            Text("Tap me to NavigatedView")
//                        }
////                        .navigationBarTitle("Tab2")//NavigationBarTitle does not work here
//                    }
////                }
//                    .tabItem { Text("Tab 2") }
//                .tag(Tabs.tab2)
//            }
//            .navigationBarTitle(returnNaviBarTitle(tabSelection: self.tabSelection))//add the NavigationBarTitle here.
//        }
//    }
//
//    enum Tabs{
//        case tab1, tab2
//    }
//
//    func returnNaviBarTitle(tabSelection: Tabs) -> String{//this function will return the correct NavigationBarTitle when different tab is selected.
//        switch tabSelection{
//            case .tab1: return "Tab1"
//            case .tab2: return "Tab2"
//        }
//    }
//}
//
//struct NavigatedView: View {
//    var body: some View {
//        Text("Hi! This is the NavigatedView")
//            .navigationBarTitle("NavigatedView")
//    }
//}


//struct ContentView: View {
//    
//    @StateObject var vm = getJoke()
//    
//    var body: some View {
//        VStack(spacing: 40) {
//            CustomDatePicker(currentDate: $vm.currentDate)
//            Button {
//                print(vm.currentDate)
//            } label: {
//                Text("Show selected date")
//            }
//
//        }
//    }
//}
