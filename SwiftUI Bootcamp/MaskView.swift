//
//  MaskView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 11.04.2022.
//

import SwiftUI

struct MaskView: View {
    
    @State var rating: Double = 3.5
    
    var body: some View {
        ZStack {
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack(spacing: 0) {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
//                    .onTapGesture {
//                        withAnimation(.easeInOut) {
//                            rating = index
//                        }
//                    }
            }
        }
    }
}
