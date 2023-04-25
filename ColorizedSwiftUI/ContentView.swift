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
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redSliderTF = ""
    @State private var greenSliderTF = ""
    @State private var blueSliderTF = ""
    @State private var alertPresented = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 10) {
                canvas(redSliderValue: redSliderValue, greenSliderValue: greenSliderValue, blueSliderValue: blueSliderValue)
                
                colorChangerView(color: .red, value: $redSliderValue, valueTF: $redSliderTF)
                    .focused($focusedField, equals: .redSliderTF)
                
                colorChangerView(color: .green, value: $greenSliderValue, valueTF: $greenSliderTF)
                    .focused($focusedField, equals: .greenSliderTF)
                
                colorChangerView(color: .blue, value: $blueSliderValue, valueTF: $blueSliderTF)
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
        .onTapGesture { UIApplication.shared.endEditing() }
    }
    
    //MARK: - Private methods
    private func changeSliderValue() {
        if focusedField == .redSliderTF {
            checkValueOf(textField: &redSliderTF)
            move(&redSliderValue, withValueOfTextField: redSliderTF)
        } else if focusedField == .greenSliderTF {
            checkValueOf(textField: &greenSliderTF)
            move(&greenSliderValue, withValueOfTextField: greenSliderTF)
        } else {
            checkValueOf(textField: &blueSliderTF)
            move(&blueSliderValue, withValueOfTextField: blueSliderTF)
        }
        focusedField = nil
    }
    
    private func checkValueOf(textField: inout String) {
        guard let value = Double(textField), (0...255).contains(value) else {
            alertPresented.toggle()
            textField = ""
            return
        }
    }
    
    private func move(_ slider: inout Double, withValueOfTextField textField: String) {
        withAnimation {
            slider = Double(textField) ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - colorChangerView
struct colorChangerView: View {
    let color: Color
    
    @Binding var value: Double
    @Binding var valueTF: String
    
    var body: some View {
        
        HStack {
            Text("\(lround(value))")
                .frame(width: 35)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
                .onChange(of: value) { newValue in
                    valueTF = string(from: newValue)
                }
            TextField("\(lround(value))", text: $valueTF)
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.decimalPad)
        }
    }
    
    private func string(from value: Double) -> String {
        String(format: "%.f", value)
    }
}

struct canvas: View {
    let redSliderValue: Double
    let greenSliderValue: Double
    let blueSliderValue: Double
    
    var body: some View {
        Color(
            red: convertValue(from: redSliderValue),
            green: convertValue(from: greenSliderValue),
            blue: convertValue(from: blueSliderValue)
        )
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 5))
        .padding(.bottom, 40)
    }
    
    private func convertValue(from value: Double) -> Double {
        value / 255
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
