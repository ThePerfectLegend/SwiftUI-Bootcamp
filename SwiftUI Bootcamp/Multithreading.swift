//
//  Multithreading.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 15.04.2022.
//

import SwiftUI

class BackgroudThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        // перевод операции в фон
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            // проверки в каком потоке находиться процесс
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            // перевод операции в основной поток
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append(String(x))
        }
        return data
    }
}

struct Multithreading: View {
    
    @StateObject var vm = BackgroudThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
