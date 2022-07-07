//
//  NavBar.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 28.04.2022.
//

import SwiftUI

struct NavBar: View {
    
    @State var pickerOptions: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SegmentPicker
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "plus")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Groups")
                    
                }
            }
        }
    }
    
    private var SegmentPicker: some View {
        VStack {
            Text("Contacts").font(.body.weight(.semibold))
            Picker("Options", selection: $pickerOptions) {
                Text("Cons").tag(0)
                Text("Prons").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)
        }
    }
    
}
