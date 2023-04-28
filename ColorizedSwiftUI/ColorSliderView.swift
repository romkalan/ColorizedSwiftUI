//
//  ColorSliderView.swift
//  ColorizedSwiftUI
//
//  Created by Roman Lantsov on 28.04.2023.
//

import SwiftUI

struct ColorSliderView: View {
    
    @Binding var value: Double
    @State private var text = ""
    @State private var alertPresented = false
    
    let color: Color
    
    var body: some View {
        
        HStack {
            Text("\(lround(value))")
                .frame(width: 35)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            TextField("\(lround(value))", text: $text)
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.decimalPad)
                .onChange(of: text) { newValue in
                    check(text: newValue)
                    withAnimation {
                        value = Double(newValue) ?? 0
                    }
                }
        }
    }
    
    private func check(text: String) {
        guard let value = Double(text), (0...255).contains(value) else {
            alertPresented.toggle()
            return
        }
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.gray)
            ColorSliderView(value: .constant(150), color: .red)
        }
    }
}
