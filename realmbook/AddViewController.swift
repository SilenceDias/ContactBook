//
//  AddViewController.swift
//  realmbook
//
//  Created by Aidos on 08.04.2022.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var gender: UITextField!
    
    let pickGender = ["male", "female"]
    var pickerView = UIPickerView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        gender.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self

    }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickGender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = pickGender[row]
        gender.resignFirstResponder()
    }
}

