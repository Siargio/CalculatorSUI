//
//  Calculator.swift
//  CalculatorSUI
//
//  Created by Sergio on 3.01.24.
//

import Foundation

class Calculator: ObservableObject {

    // used to update the UI
    @Published var displayValue = "0"

    // Store the current operator
    var currentOp: Operator?

    // Current number selected
    var currentNumber: Double? = 0

    // Previous number selected
    var previousNumber: Double?

    // Flag for equal press
    var equaled = false

    // How many decimal places have been typed
    var decimalPlace = 0

    // Selects the appropriate function based on the label of the button pressed
    func buttonPressed(label: String) {
        if label == "CE" {
            displayValue = "0"
            reset()

        } else if label == "=" {
            equalsClocked()
        } else if label == "." {
            decimalClicked()
        } else if let value = Double(label) {
            numberPressed(value: value)
        } else {
            operatorPressed(op: Operator())
            
        }

    }
    
    func setDisplayValue(number: Double) {
        
        // Don't display a decimal if the number is an integer
        if number == floor(number) {
            displayValue = "\(Int(number))"

            // Otherwise, display the decimal
        } else {
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10, decimalPlaces)) / pow(10, decimalPlaces))"
        }
    }

    /// Resets the state calculator
    func reset() {
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
    }

    func equalsClocked() {

    }
    
    func decimalClicked() {

    }

    func numberPressed(value: Double) {
        // If equals was pressed, clear the current numbers
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }

        // If there is no current number, set it to the value
        if currentNumber == nil {
            currentNumber = value / pow(10, decimalPlace)

            // Otherwise, add the value to the current number
        } else {
            // IF no decimal was typed, add the value as the last digit of the number
            if decimalPlace == 0 {
                currentNumber = currentNumber! * 10 + value

                // Otherwise, add the value as the last decimal of the number
            } else {
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
            }
        }

        // Update the UI
        setDisplayValue(number: currentNumber!)
    }

    func operatorPressed(op: Operator) {

    }
}

func pow(_ base: Int, _ exp: Int) -> Double {
    return pow(Double(base), Double(exp))
}
