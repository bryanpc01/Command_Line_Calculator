//
//  main.swift
//  Calculator
//
//  Created by Phillip Bryan on 7/21/19.
//  Copyright © 2019 Phillip Bryan. All rights reserved.
//

import Foundation

enum Operation: String {
    case add = "+"
    case multiply = "*"
    case divide = "/"
    case subtract = "-"
}

func randomOperation() -> Operation {
    let randomNum = Int.random(in: 1...4)
    switch randomNum {
    case 1:
        return .add
    case 2:
        return.subtract
    case 3:
        return .multiply
    case 4:
        return .divide
    default:
        return .multiply
    }
}

var operations: ([Operation: (Double, Double) -> Double]) = [.add     : { $0 + $1 },
                                                             .subtract: { $0 - $1 },
                                                             .multiply: { $0 * $1 },
                                                             .divide  : { $0 / $1 }]

var parsedUserInput = [String.SubSequence]()

let numberFormatter = NumberFormatter()
numberFormatter.minimumIntegerDigits = 1
numberFormatter.maximumFractionDigits = 2

func handleMath() {
    print("Enter your calculation: ", terminator: "")
    
    guard let potentialUserInput = readLine() else { return }
    
    if potentialUserInput == ""{ print("Invlaid input."); return }
    
    parsedUserInput = potentialUserInput.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    if parsedUserInput.count == 3 || parsedUserInput[3] == "=" {
        if let num1 = Double(parsedUserInput[0]), let num2 = Double(parsedUserInput[2]) {
            if let operand = Operation.init(rawValue: String(parsedUserInput[1])), let doMath = operations[operand], let formattedAnswer = numberFormatter.string(from: NSNumber(value: doMath(num1,num2))){
                if parsedUserInput.count == 3 {
                    parsedUserInput.append("=")
                }
                let formattedQuestion = parsedUserInput.joined(separator: " ")
                print( formattedQuestion, formattedAnswer )
            } else {
                print("\(parsedUserInput[1]) is not a valid operation.")
            }
        } else {
            print("Please check your input numbers.\nNumber 1: \(parsedUserInput[0]), Number 2: \(parsedUserInput[2])")
        }
    } else {
        print("Input is invalid.")
    }
}

func mathBlitz() {
    let num1 = Int.random(in: 1...20)
    let num2 = Int.random(in: 1...20)
    let operand = randomOperation()
    
    if let doMath = operations[operand] {
        print(num1, operand.rawValue, num2, "=", terminator: " ")
        
        if let userInput = readLine(), let answer = Double(userInput), let correctAnswer = numberFormatter.string(from: NSNumber(value: doMath(Double(num1),Double(num2)))), let userAnswer = numberFormatter.string(from: NSNumber(value: answer)){
            correctAnswer == userAnswer ? print("Correct") : print("Incorrect")
        } else {
            print("Please enter valid input.")
        }
    }
    
    
}

mathBlitz()
mathBlitz()
mathBlitz()
mathBlitz()
