//
//  UnitTestingView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 22.12.2023.
//

import SwiftUI

/*
 1. Unit Test - tests business logic
 2. UI Test - tests UI
 */

struct UnitTestingView: View {
    
    @StateObject private var viewModel: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTestingView(isPremium: true)
}
