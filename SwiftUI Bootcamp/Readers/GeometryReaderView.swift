//
//  GeometryReaderView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 09.04.2022.
//

import SwiftUI

struct GeometryReaderView: View {
    
    func getPrecentage(geo: GeometryProxy) -> Double {
        let maxDistance  = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return  Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPrecentage(geo: geo) * 10),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
}
