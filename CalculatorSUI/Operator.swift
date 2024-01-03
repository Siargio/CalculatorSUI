//
//  Operator.swift
//  CalculatorSUI
//
//  Created by Sergio on 3.01.24.
//

import Foundation

class Operator {
    
    var op: (Double, Double) -> Double
    var isDivison = false

    init(_ string: String) {

        if string == "+" {
            self.op = (+)

        } else if string == "-" {
            self.op = (-)

        } else if string == String("\u{00d7}") {
            self.op = (*)

        } else {
            self.op = (/)
            self.isDivison = true
        }
    }
}
