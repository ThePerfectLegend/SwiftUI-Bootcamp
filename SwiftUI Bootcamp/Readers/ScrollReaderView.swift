//
//  ScrollReaderView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 09.04.2022.
//

import SwiftUI

struct ScrollReaderView: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter # here", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                if let index = Int(textFieldText) {
                    scrollToIndex = index
                    
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("Text # \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}
