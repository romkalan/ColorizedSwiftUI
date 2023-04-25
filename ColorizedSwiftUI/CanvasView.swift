//
//  CanvasView.swift
//  ColorizedSwiftUI
//
//  Created by Roman Lantsov on 25.04.2023.
//

import SwiftUI

struct CanvasView: View {
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

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView(redSliderValue: 0.5, greenSliderValue: 0.5, blueSliderValue: 0.5)
    }
}
