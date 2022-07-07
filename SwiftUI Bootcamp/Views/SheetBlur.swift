//
//  SheetBlur.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 28.04.2022.
//

import SwiftUI

struct SheetBlur: View {
    
    @State var showSheed = false
    
    var body: some View {
        VStack {
            Button {
                showSheed = true
            } label: {
                Text("Show Sheed")
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .sheet(isPresented: $showSheed, onDismiss: {
            showSheed = false
        }) {
            sheedView
        }

    }
    
    private var sheedView: some View {
        VStack {
        Image(systemName: "flame.fill").font(.largeTitle.weight(.bold))
                .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.ultraThinMaterial)
        .background(Blur(style: .dark))
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}



struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
        
    }
}

extension View {
    func clearModalBackground() -> some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

