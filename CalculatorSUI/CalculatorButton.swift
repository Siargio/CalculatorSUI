//
//  CalculatorButton.swift
//  CalculatorSUI
//
//  Created by Sergio on 3.01.24.
//

import SwiftUI

struct CalculatorButton: View {
    @EnvironmentObject var calculator: Calculator
    var label: String
    var color: Color

    var body: some View {
        Button {
            // Inform model of button press
            calculator.buttonPressed(label: label)
        } label: {
            ZStack {
                Circle()
                    .fill(color)

                Text(label)
                    .font(.title)
            }
        }
        //we want white color text for the button
        .accentColor(.white)
    }
}

#Preview {
    CalculatorButton(label: "1", color: .gray)
        .previewLayout(.fixed(width: 100, height: 100))
        .environmentObject(Calculator())
}
