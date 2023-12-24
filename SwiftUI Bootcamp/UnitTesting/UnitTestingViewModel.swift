//
//  UnitTestingViewModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 22.12.2023.
//

import SwiftUI
import Combine

class UnitTestingViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
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
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadDataWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)
    }
    
}
