//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Romain Francois on 12/06/2020.
//  Copyright © 2020 Romain Francois. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipPercentage: UITextField!
    @IBOutlet weak var numberOfPpl: UITextField!
    
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalPayment: UILabel!
    @IBOutlet weak var paymentPerPerson: UILabel!
    
    var textFields: [UITextField] {
        return [billAmount, tipPercentage, numberOfPpl]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textFields.forEach { $0.delegate = self }
        
        setupToolbar()
    }

    @IBAction func calculateTip(_ sender: Any) {
        let _tipPercentage = Double(tipPercentage.text!) ?? 0
        let _billAmount = Double(billAmount.text!) ?? 0
        let _numberOfPpl = Double(numberOfPpl.text!) ?? 0
        
        let _tipAmount = ceil(_tipPercentage / 100.0 * _billAmount)
        let _totalPayment = ceil(_tipAmount + _billAmount)
        let _paymentPerPerson = ceil(_totalPayment / _numberOfPpl)
        
        
        tipAmount.text = String(_tipAmount)
        totalPayment.text = String(_totalPayment)
        paymentPerPerson.text = String(_paymentPerPerson)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder() // last textfield, dismiss keyboard directly
        }
    }
    
    func setupToolbar(){
        //Create a toolbar
        let bar = UIToolbar()
        
        //Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        
        let nextBtn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(selectNextTextField))
        
        //Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //Add the created button items in the toobar
        bar.items = [doneBtn, flexSpace, nextBtn]
        bar.sizeToFit()
        
        //Add the toolbar to our textfield
        billAmount.inputAccessoryView = bar
        billAmount.returnKeyType = .next
        tipPercentage.inputAccessoryView = bar
        numberOfPpl.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    @objc func selectNextTextField(sender:UIButton){
        print("action: \(sender)")
        
        if billAmount.isFirstResponder {
            textFieldShouldReturn(billAmount)
        } else if tipPercentage.isFirstResponder {
            textFieldShouldReturn(tipPercentage)
        } else if numberOfPpl.isFirstResponder {
           textFieldShouldReturn(numberOfPpl)
       }
    }
}

