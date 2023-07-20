//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isFloat: Bool = false
    var isOperating: Bool = false
    var isCompleteOperation = false
    var activeOperator: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculatorLabel.text = "0"
    }
    
    @IBOutlet weak var calculatorLabel: UILabel!
    
    @IBAction func clickButton(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else { return }
        self.handleButton(buttonText.lowercased())
    }
    
    func handleButton(_ buttonTag: String) {
        switch buttonTag {
        case "ac":
            refreshCalculator()
            
        case "+/-":
            oppositeValue()
            
        case "%":
            print("%")
            
        case "+":
            operate(buttonTag)
        case "-":
            operate(buttonTag)
        case "×":
            operate(buttonTag)
        case "÷":
            operate(buttonTag)
            
        case "=":
            executeOperation()
            
        case ".":
            print(".")
            
        default:
            self.handleNumberButton(buttonTag)
        }
    }
    
    func setNewTextValue(_ value: String) {
        self.calculatorLabel.text = formmatedNumber(value)
    }
    
    func refreshCalculator() {
        self.calculatorLabel.text = "0"
        self.isFloat = false
        self.isOperating = false
        self.isCompleteOperation = false
        self.activeOperator = ""
    }
    
    func formmatedNumber(_ value: String) -> String {
        let valueArray = value.components(separatedBy: ".")
        
        if(valueArray.count == 1) {
            return value
        }
        
        return valueArray[1] == "0" ? valueArray[0] : value
    }
    
    func handleNumberButton(_ numberText: String) {
        guard let textValue = self.calculatorLabel.text else { return }
        if textValue == "0" {
            setNewTextValue(numberText)
            return
        }
        
        if self.isOperating {
            self.isCompleteOperation = true
        }
        setNewTextValue(textValue + numberText)
    }
    
    func operate(_ mOperator: String) {
        guard let textValue = self.calculatorLabel.text else { return }
        
        if textValue == "0" {
            return
        }
        
        if self.isOperating {
            setNewTextValue(textValue.replacingOccurrences(of: self.activeOperator, with: mOperator))
            self.activeOperator = mOperator
            return
        }
        
        self.isOperating = true
        self.activeOperator = mOperator
        setNewTextValue(textValue + mOperator)
    }
    
    func oppositeValue() {
        guard let value = Double(self.calculatorLabel.text!) else { return }
        if self.isOperating {
            return
        }
        self.setNewTextValue("\(value * -1)")
    }
    
    func executeOperation() {
        if !self.isOperating || !self.isCompleteOperation {
            return
        }
        guard let value = self.calculatorLabel.text else { return }
        let valueArray = value.components(separatedBy: self.activeOperator)
        var operatedValue: Double = 0
        
        switch self.activeOperator {
        case "+":
            operatedValue = Double(valueArray[0])! + Double(valueArray[1])!
        case "-":
            operatedValue = Double(valueArray[0])! - Double(valueArray[1])!
        case "×":
            operatedValue = Double(valueArray[0])! * Double(valueArray[1])!
        case "÷":
            operatedValue = Double(valueArray[0])! / Double(valueArray[1])!
        default:
            print("Not Expected Operator")
        }
        
        self.setNewTextValue("\(operatedValue)")
    }
}

