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
            equalsClicked()
        } else if label == "." {
            decimalClicked()
        } else if let value = Double(label) {
            numberPressed(value: value)
        } else {
            operatorPressed(op: Operator(label))
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
    
    // Returns true of division by 0 could happen
    func checkForDivision() -> Bool {
        if currentOp!.isDivison && (currentNumber == nil && previousNumber == 0 || currentNumber == 0) {
            displayValue = "Error"
            reset()
            return true
        }
        return false
    }

    func equalsClicked() {

        // Check if we have an operation to perform
        if currentOp != nil {

            // Reset the decimal place for the current number
            decimalPlace = 0

            // Guard for division by 0
            if checkForDivision() { return }

            // Check if we have at least one operand
            if currentNumber != nil || previousNumber != nil {
                // Compute the total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)

                // Update the first operand
                if currentNumber == nil {
                    currentNumber = previousNumber
                }

                // Update the second operand
                previousNumber = total


                // Set the equaled flag
                equaled = true

                // Update the UI
                setDisplayValue(number: total)
            }
        }
    }
    
    func decimalClicked() {
        
        // If equals was pressed, reset the current numbers
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }

        // If a "." was typed first, set the current number
        if currentNumber == nil {
            currentNumber = 0
        }

        // Set the decimal place
        decimalPlace = 1

        // Update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
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
        
        // Reset the decimal
        decimalPlace = 0

        // If equals was pressed, reset the current number
        if equaled {
            currentNumber = nil
            equaled = false
        }

        // If we have two operands, compute them
        if currentNumber != nil && previousNumber != nil {
            if checkForDivision() { return }
            let total = currentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil

            // Update the UI
            setDisplayValue(number: total)

            // If only number has been given, move it to the second operand
        } else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }

        currentOp = op
    }
}

func pow(_ base: Int, _ exp: Int) -> Double {
    return pow(Double(base), Double(exp))
}
