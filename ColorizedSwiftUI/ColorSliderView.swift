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
            Text(value.formatted())
                .frame(width: 35)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            TextField("", text: $text) { _ in
                withAnimation {
                    checkValue()
                    value = Double(text) ?? 0
                }
            }
            .textFieldStyle(.roundedBorder)
            .frame(width: 45)
            .keyboardType(.decimalPad)
            .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                Text("Please enter value from 0 to 255")
            }
        }
        .onAppear {
            text = value.formatted()
        }
    }
    
    private func checkValue() {
        if let value = Int(text), (0...255).contains(value) {
            self.value = Double(value)
            return
        }
        alertPresented.toggle()
        value = 0
        text = "0"
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
