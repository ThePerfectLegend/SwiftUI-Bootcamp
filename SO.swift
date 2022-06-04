//
//  SO.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.04.2022.
//

import SwiftUI

struct MyView: View {

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = UIColor.red
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some View {
        NavigationView {
                VStack {
                    Rectangle().foregroundColor(Color(UIColor.red)).frame(height: 100)
                    Spacer()
                }
            ScrollView(.vertical) {
                Text("Hello world")
            }
        }
    }
}

//struct AppInfoView: View {
//        @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//        var body: some View {
//            ZStack{
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color("homepage_bg")).ignoresSafeArea(.all)
//            .onAppear{
//                UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
//                    if let view = v as? UITabBar {
//                        view.isHidden = true
//                    }
//                })
//            }
////            .onDisAppear(...) //it works too. But seeing TabBar shown bit delay when naviagting back. So below the customizable back button.
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: Button(action : {
//                self.mode.wrappedValue.dismiss()
//                UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
//                    if let view = v as? UITabBar {
//                        view.isHidden = false
//                    }
//                })
//            }){
//                Image(systemName: "chevron.left")
//            })
//        }
//}
//
//extension UIView {
//
//        func allSubviews() -> [UIView] {
//            var res = self.subviews
//            for subview in self.subviews {
//                let riz = subview.allSubviews()
//                res.append(contentsOf: riz)
//            }
//            return res
//        }
//    }

//
//struct Workout: Identifiable {
//    let id = UUID().uuidString
//    let name: String
//    let image: String
//}
//
//class WorkoutViewModel: ObservableObject {
//    var workouts: [Workout] = [
//    Workout(name: "Push", image: "flame.fill"),
//    Workout(name: "Pull", image: "externaldrive.connected.to.line.below"),
//    Workout(name: "Legs", image: "florinsign.circle")
//    ]
//}
//
//struct CardView: View {
//
//    var workout: Workout
//
//    var body: some View {
//        VStack {
//            Image(systemName: workout.image)
//                .resizable()
//                .frame(width: 75, height: 75)
//            Text(workout.name)
//                .font(.subheadline)
//        }
//    }
//}
//
//struct CardDetailView: View {
//
//    var workout: Workout
//
//    var body: some View {
//        VStack {
//            Image(systemName: workout.image)
//                .resizable()
//                .frame(width: 150, height: 150)
//            Text(workout.name)
//                .font(.title)
//                .fontWeight(.semibold)
//        }
//    }
//}
//
//struct FinalView: View {
//
//    var vm = WorkoutViewModel()
//
//    var body: some View {
//        NavigationView {
//            HStack(spacing: 20) {
//                ForEach(vm.workouts) { workout in
//                    NavigationLink(destination: CardDetailView(workout: workout)) {
//                        CardView(workout: workout)
//                    }
//                }
//            }
//        }
//    }
//}
//
