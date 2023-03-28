//
//  ViewController.swift
//  Converter
//
//  Created by Евгений Михневич on 07.06.2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var lengthsTextField1: UITextField!
    @IBOutlet weak var lengthsTextField2: UITextField!
    @IBOutlet weak var weightsTextField1: UITextField!
    @IBOutlet weak var weightsTextField2: UITextField!
    @IBOutlet weak var lengthAmountTextField1: UITextField!
    @IBOutlet weak var lengthAmountTextField2: UITextField!
    @IBOutlet weak var weightAmountTextField1: UITextField!
    @IBOutlet weak var weightAmountTextField2: UITextField!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return lengths.count
        case 2: return lengths.count
        case 3: return weigths.count
        case 4: return weigths.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return lengths[row]
        case 2: return lengths[row]
        case 3: return weigths[row]
        case 4: return weigths[row]
        default: return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            lengthsTextField1.text = lengths[row]
            lengthsTextField1.resignFirstResponder()
        case 2:
            lengthsTextField2.text = lengths[row]
            lengthsTextField2.resignFirstResponder()
        case 3:
            weightsTextField1.text = weigths[row]
            weightsTextField1.resignFirstResponder()
        case 4:
            weightsTextField2.text = weigths[row]
            weightsTextField2.resignFirstResponder()
        default: return
        }
    }
    
    let lengths = ["Kilometers", "Miles"]
    let weigths = ["Kilograms", "Pounds"]
    let lengthsPickerView1 = UIPickerView()
    let lengthsPickerView2 = UIPickerView()
    let weigthsPickerView1 = UIPickerView()
    let weigthsPickerView2 = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lengthsPickerView1.delegate = self
        lengthsPickerView1.dataSource = self
        lengthsPickerView1.tag = 1
        
        lengthsPickerView2.delegate = self
        lengthsPickerView2.dataSource = self
        lengthsPickerView2.tag = 2
        
        weigthsPickerView1.delegate = self
        weigthsPickerView1.dataSource = self
        weigthsPickerView1.tag = 3
        
        weigthsPickerView2.delegate = self
        weigthsPickerView2.dataSource = self
        weigthsPickerView2.tag = 4
        
        lengthsTextField1.placeholder = "Select length measurement"
        lengthsTextField1.inputView = lengthsPickerView1
        
        lengthsTextField2.placeholder = "Select length measurement"
        lengthsTextField2.inputView = lengthsPickerView2
        
        weightsTextField1.placeholder = "Select weight measurement"
        weightsTextField1.inputView = weigthsPickerView1
        
        weightsTextField2.placeholder = "Select weight measurement"
        weightsTextField2.inputView = weigthsPickerView2
    }
    
    let milesToKilometersRatio = 1.60934
    let kilogramsToPoundsRatio = 2.20462
    
    func roundToFourSymbols (number: Double) -> Double{
        return round(number*10000)/10000
    }
    

    @IBAction func lengthAmountTextField1Changed(_ sender: Any) {
        if lengthsTextField1.text == "Miles" && lengthsTextField2.text == "Kilometers"{
            let amount = (Double(lengthAmountTextField1.text ?? "0") ?? -1)
            if amount == -1 {
                lengthAmountTextField2.text = "Error"
            } else {
                lengthAmountTextField2.text = String(roundToFourSymbols (number: (amount * milesToKilometersRatio)))
            }
        } else if lengthsTextField1.text == "Kilometers" && lengthsTextField2.text == "Miles"{
            let amount = (Double(lengthAmountTextField1.text ?? "0") ?? -1)
            if amount == -1 {
                lengthAmountTextField2.text = "Error"
            } else {
                lengthAmountTextField2.text = String(roundToFourSymbols (number: (amount / milesToKilometersRatio)))
            }
        } else if lengthsTextField1.text == "Miles" && lengthsTextField2.text == "Miles" {
            lengthAmountTextField2.text = lengthAmountTextField1.text
        } else if lengthsTextField1.text == "Kilometers" && lengthsTextField2.text == "Kilometers" {
            lengthAmountTextField2.text = lengthAmountTextField1.text
        }
    }
    
    @IBAction func lengthAmountTextField2Changed(_ sender: Any) {
        if lengthsTextField1.text == "Miles" && lengthsTextField2.text == "Kilometers"{
            let amount = (Double(lengthAmountTextField2.text ?? "0") ?? 0) / milesToKilometersRatio
            lengthAmountTextField1.text = String(roundToFourSymbols (number: amount))
        } else if lengthsTextField1.text == "Kilometers" && lengthsTextField2.text == "Miles"{
            let amount = (Double(lengthAmountTextField2.text ?? "0") ?? 0) * milesToKilometersRatio
            lengthAmountTextField1.text = String(roundToFourSymbols(number: amount))
        } else if lengthsTextField1.text == "Miles" && lengthsTextField2.text == "Miles" {
            lengthAmountTextField1.text = lengthAmountTextField2.text
        } else if lengthsTextField1.text == "Kilometers" && lengthsTextField2.text == "Kilometers" {
            lengthAmountTextField1.text = lengthAmountTextField2.text
        }
    }
    
    @IBAction func weightAmountTextField1Changed(_ sender: Any) {
        if weightsTextField1.text == "Kilograms" && weightsTextField2.text == "Pounds"{
            let amount = (Double(weightAmountTextField1.text ?? "0") ?? 0) * kilogramsToPoundsRatio
            weightAmountTextField2.text = String(roundToFourSymbols (number: amount))
        } else if weightsTextField1.text == "Pounds" && weightsTextField2.text == "Kilograms"{
            let amount = (Double(weightAmountTextField1.text ?? "0") ?? 0) / kilogramsToPoundsRatio
            weightAmountTextField2.text = String(roundToFourSymbols(number: amount))
        } else if weightsTextField1.text == "Kilograms" && weightsTextField2.text == "Kilograms" {
            weightAmountTextField2.text = weightAmountTextField1.text
        } else if weightsTextField1.text == "Pounds" && weightsTextField2.text == "Pounds" {
            weightAmountTextField2.text = weightAmountTextField1.text
        }
    }
    
    @IBAction func weightAmountTextFiled2Changed(_ sender: Any) {
        if weightsTextField1.text == "Kilograms" && weightsTextField2.text == "Pounds"{
            let amount = (Double(weightAmountTextField2.text ?? "0") ?? 0) / kilogramsToPoundsRatio
            weightAmountTextField1.text = String(roundToFourSymbols (number: amount))
        } else if weightsTextField1.text == "Pounds" && weightsTextField2.text == "Kilograms"{
            let amount = (Double(weightAmountTextField2.text ?? "0") ?? 0) * kilogramsToPoundsRatio
            weightAmountTextField1.text = String(roundToFourSymbols(number: amount))
        } else if weightsTextField1.text == "Kilograms" && weightsTextField2.text == "Kilograms" {
            weightAmountTextField1.text = weightAmountTextField2.text
        } else if weightsTextField1.text == "Pounds" && weightsTextField2.text == "Pounds" {
            weightAmountTextField1.text = weightAmountTextField2.text
        }
    }
}

