//
//  MultipleSheets.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 10.04.2022.
//

import SwiftUI

struct RndModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheets: View {
    
    @State var selectedModel: RndModel? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RndModel(title: "ONE")
            }
            
            Button("Button 2") {
                selectedModel = RndModel(title: "TWO")
            }
        }
        .sheet(item: $selectedModel) { model in
            NextSheed(selectedModel: model)
        }
    }
}

struct NextSheed: View {
    
    let selectedModel: RndModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

