//
//  UnitTestingViewModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 22.12.2023.
//

import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping(_ items: [String]) -> Void)
    func downloadDataWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["One", "Two", "Three"]
    }
    
    func downloadItemsWithEscaping(completion: @escaping(_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadDataWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
    
}

class UnitTestingViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataServiceProtocol
    init(
        isPremium: Bool,
        dataService: NewDataServiceProtocol = NewMockDataService(items: nil)
    ) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }
    
    func selectItem(_ item: String) {
        if let checkingItem = dataArray.first(where: { $0 == item }) {
            selectedItem = checkingItem
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(_ item: String) throws {
        
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let checkingItem = dataArray.first(where: { $0 == item }) {
            print("Save item here \(checkingItem)")
        } else {
            throw DataError.notFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case notFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { items in
            self.dataArray = items
        }
    }
    
}
