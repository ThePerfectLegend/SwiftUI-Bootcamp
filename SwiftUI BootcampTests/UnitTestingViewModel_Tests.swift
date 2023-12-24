//
//  UnitTestingViewModel_Tests.swift
//  SwiftUI BootcampTests
//
//  Created by Nizami Tagiyev on 22.12.2023.
//

import XCTest
@testable import SwiftUI_Bootcamp
import Combine

// Naming Stricture: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Stricture: test_[Struct or Class]_[var or func]_[expected results]

// Testing Structure: Given, When, Then

final class UnitTestingViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let viewModel = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(viewModel.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        
        // When
        let viewModel = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(viewModel.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let viewModel = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(viewModel.isPremium, userIsPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let viewModel = UnitTestingViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(viewModel.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, loopCount)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlancString() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        viewModel.addItem(item: "")
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlancString2() {
        // Given
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        // When
        viewModel.addItem(item: "")
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        
        // When
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        viewModel.selectItem(UUID().uuidString)
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelected() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let newItem = UUID().uuidString
        viewModel.addItem(item: newItem)
        viewModel.selectItem(newItem)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, newItem)
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelected_stress() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        viewModel.selectItem(randomItem)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, randomItem)
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When

        
        // Then
        
        do {
            try viewModel.saveItem("")
        } catch let error {
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
        
//        XCTAssertThrowsError(try viewModel.saveItem(""))
//        XCTAssertThrowsError(try viewModel.saveItem(""), "Should throw Item No Item Found Error") { error in
//            let returnedError = error as? UnitTestingViewModel.DataError
//            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
//        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(UUID().uuidString))
        XCTAssertThrowsError(try viewModel.saveItem(UUID().uuidString), "Should throw Item No Data Error") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.notFound)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem() {
        // Given
        let viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        
        // Then
        XCTAssertFalse(randomItem.isEmpty)
//        XCTAssertNoThrow(try viewModel.saveItem(randomItem))
        
        do {
            try viewModel.saveItem(randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 sec")
        
        viewModel.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadWithEscaping()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 sec")
        
        viewModel.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.downloadWithCombine()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
    }

}
