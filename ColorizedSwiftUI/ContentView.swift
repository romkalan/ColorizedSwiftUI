//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Roman Lantsov on 24.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    @State private var redSliderTF = ""
    @State private var greenSliderTF = ""
    @State private var blueSliderTF = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 10) {
                Color(
                    red: convertValue(from: redSliderValue),
                    green: convertValue(from: greenSliderValue),
                    blue: convertValue(from: blueSliderValue)
                )
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 5))
                    .padding(.bottom, 40)
                HStack {
                    Text("\(lround(redSliderValue))")
                        .frame(width: 35)
                        .foregroundColor(.white)
                    Slider(value: $redSliderValue, in: 0...255, step: 1)
                        .accentColor(.red)
                    TextField("\(lround(redSliderValue))", text: $redSliderTF)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                }
                HStack {
                    Text("\(lround(greenSliderValue))")
                        .frame(width: 35)
                        .foregroundColor(.white)
                    Slider(value: $greenSliderValue, in: 0...255, step: 1)
                        .accentColor(.green)
                    TextField("\(lround(greenSliderValue))", text: $greenSliderTF)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                }
                HStack {
                    Text("\(lround(blueSliderValue))")
                        .frame(width: 35)
                        .foregroundColor(.white)
                    Slider(value: $blueSliderValue, in: 0...255, step: 1)
                        .accentColor(.blue)
                    TextField("\(lround(blueSliderValue))", text: $blueSliderTF)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func convertValue(from value: Double) -> Double {
        value / 255
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
