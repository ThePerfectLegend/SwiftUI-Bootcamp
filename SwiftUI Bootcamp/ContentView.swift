//
//  ContentView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 05.04.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MaskView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
