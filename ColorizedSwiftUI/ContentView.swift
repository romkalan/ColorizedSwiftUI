//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Roman Lantsov on 24.04.2023.
//

import SwiftUI

enum Field: Hashable {
    case redSliderTF
    case greenSliderTF
    case blueSliderTF
}

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255).rounded()
    @State private var greenSliderValue = Double.random(in: 0...255).rounded()
    @State private var blueSliderValue = Double.random(in: 0...255).rounded()
    
    @State private var alertPresented = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            VStack(spacing: 10) {
                CanvasView(
                    redSliderValue: redSliderValue,
                    greenSliderValue: greenSliderValue,
                    blueSliderValue: blueSliderValue
                )
                    .padding(.bottom, 40)
                
                ColorSliderView(value: $redSliderValue, color: .red)
                    .focused($focusedField, equals: .redSliderTF)
                
                ColorSliderView(value: $greenSliderValue, color: .green)
                    .focused($focusedField, equals: .greenSliderTF)
                
                ColorSliderView(value: $blueSliderValue, color: .blue)
                    .focused($focusedField, equals: .blueSliderTF)
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done", action: changeSliderValue)
                        .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                            Text("Please enter correct value")
                        }
                }
            }
            .padding()
        }
    }
    
    //MARK: - Private methods
    private func changeSliderValue() {
        if focusedField == .redSliderTF {
            check(text: redSliderValue.formatted())
        } else if focusedField == .greenSliderTF {
            check(text: greenSliderValue.formatted())
        } else {
            check(text: blueSliderValue.formatted())
        }
        focusedField = nil
    }
    
    private func check(text: String) {
        guard let value = Double(text), (0...255).contains(value) else {
            alertPresented.toggle()
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

