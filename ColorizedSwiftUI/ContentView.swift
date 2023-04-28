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
                    Button(action: previousField) {
                        Image(systemName: "chevron.up")
                    }
                    Button(action: nextField) {
                        Image(systemName: "chevron.down")
                    }
                    
                    Spacer()
                    Button("Done", action: { focusedField = nil })
                }
            }
            .padding()
        }
    }
    
    //MARK: - Private methods
    private func nextField() {
        switch focusedField {
        case .redSliderTF:
            focusedField = .greenSliderTF
        case .greenSliderTF:
            focusedField = .blueSliderTF
        case .blueSliderTF:
            focusedField = .redSliderTF
        case .none:
            focusedField = .none
        }
    }
    
    private func previousField() {
        switch focusedField {
        case .redSliderTF:
            focusedField = .blueSliderTF
        case .greenSliderTF:
            focusedField = .redSliderTF
        case .blueSliderTF:
            focusedField = .greenSliderTF
        case .none:
            focusedField = .none
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

