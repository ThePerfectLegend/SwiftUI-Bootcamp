//
//  AdvancedCombine.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 16.07.2022.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    //    @Published var basicPablisher: String = ""
    //    let currentValuePublisher = CurrentValueSubject<Int, Error>(0)
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0..<11)
        for itemIndex in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(itemIndex)) {
                self.passThroughPublisher.send(items[itemIndex])
                
                if itemIndex > 4 && itemIndex < 8 {
                    self.boolPublisher.send(false)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(true)
                }
                
                // trigger the end of sending values to subscribers, need for using .last and .last(where:) in Sequence Operations & Mathematic Operations
                if itemIndex == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
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
        dataService.passThroughPublisher
        
        // Sequence Operations
//            .first()
//            .first(where: { $0 > 4 })
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .last()
//            .last(where: { $0 < 4 })
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
//            .dropFirst()
//            .dropFirst(3)
//            .drop(while: { $0 < 5 })
//            .tryDrop(while: { int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6 })
//            .prefix(4)
//            .prefix(while: { $0 < 5 })
//            .output(at: 7)
//            .output(in: 2..<4)
        
        // Mathematic Operations
//            .max()
//            .max(by: { int1, int2 in
//                return int1 < int2
//            })
//            .tryMax(by: )
//            .min()
        
        // Filtering/Redusing
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
//            .compactMap({ int in
//                if int == 5 {
//                    return nil
//                }
//                return String(int)
//            })
//            .tryCompactMap()
//            .first(where: { $0 > 3 && $0 < 7 })
//            .removeDuplicates()
//            .replaceNil(with: 7)
//            .collect()
//            .collect(3)
//            .allSatisfy({ $0 == 5 })
        
        // Timing Operations
//            .debounce(for: 1.0, scheduler: DispatchQueue.main)
//            .delay(for: 2, scheduler: DispatchQueue.main)
//            .measureInterval(using: DispatchQueue.main) // time between publishers
//            .throttle(for: 10.0, scheduler: DispatchQueue.main, latest: true) // wait between publish values
//            .retry(3) // retry to do something if got error
//            .timeout(0.75, scheduler: DispatchQueue.main) //if time between publishers more that 0.75 then terminating publishing
        
        //Multiple Publishers and Subscribers
//            .combineLatest(dataService.boolPublisher) // listen two publishers, to start flow need values from both publishers
//            .compactMap({ (int, bool) in
//                if bool {
//                    return String(int)
//                }
//                return nil
//            })
//            .compactMap({ $1 ? String($0) : nil })
//            .merge(with: dataService.intPublisher)   // merging different publishers in to same pipeline
//            .zip(dataService.boolPublisher)          // zipping different values in one publisher tuple
//            .map({ tuple in
//                return String(tuple.1) + tuple.1.description
//            })
//            .catch({ error in                       // return value from another publisher if error
//                return self.dataService.intPublisher
//            })
        
        
            .map({ String($0) })
            .sink { complition in
                switch complition {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
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

