//
//  FuturesBootcamp.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 17.07.2022.
//

import SwiftUI
import Combine

// download with Combine
// download with @escaping closure
// download with async/await

class FuturesViewModel: ObservableObject {
    
    @Published var title = "Starting title"
    
    let url = URL(string: "https://www.google.com/")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        
        getEscapingClosure { [weak self] returnedValue, error in
            self?.title = returnedValue
        }
        
//        getCombinePublisher()
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1.0, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(comletionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            comletionHandler("New value 2", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
}

struct FuturesBootcamp: View {
    
    @StateObject var vm = FuturesViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}
