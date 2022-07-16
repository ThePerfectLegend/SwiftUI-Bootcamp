//
//  SubscriberText.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI
import Combine

class SubscriberTextViewModel: ObservableObject {
    
    @Published var textFieldText: String = ""
    @Published var textIsValid = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        addTextFieldSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // waiting for end typing
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self) // don't have options to use [weak self]
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
}

struct SubscriberText: View {
    @StateObject var vm = SubscriberTextViewModel()
    
    var body: some View {
        VStack {
            TextField("Type something...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.secondary)
                .cornerRadius(10)
                .font(.headline)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0:
                                vm.textIsValid ? 0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
        }
        .padding()
    }
}

