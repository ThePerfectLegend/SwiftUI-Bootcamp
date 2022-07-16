//
//  AdvancedCombine.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
        
    @Published var basicPablisher: [String] = []
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.basicPablisher = ["one", "two", "three"]
        }
    }
}

class AdvancedCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$basicPablisher
            .sink { complition in
                switch complition {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data = returnedValue
            }
            .store(in: &cancellables)

    }
    
}

struct AdvancedCombine: View {
    
    @StateObject var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) {
                    Text($0.uppercased())
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .monospacedDigit()
                }
            }
            .padding()
        }
    }
}

