//
//  CalculatorRow.swift
//  CalculatorSUI
//
//  Created by Sergio on 3.01.24.
//

import SwiftUI

let columnCount = 4

struct CalculatorRow: View {
    var labels = ["", "", "", "",]
    var colors: [Color] = [.gray, .gray, .gray, .orange]

    var body: some View {
        // Display a calculator button for each column
        HStack(spacing: 10) {
            // Select from the labels and colors
            ForEach(0..<columnCount) { index in
                CalculatorButton(label: labels[index], color: colors[index])
            }
        }
    }
}

#Preview {
    CalculatorRow(labels: ["1", "2", "3", "+"])
        .previewLayout(.fixed(width: 300, height: 100))
}
