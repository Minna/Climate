//
//  ViewController.swift
//  Climate
//
//  Created by Minna on 13/04/21.
//

import UIKit

class WheatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    let wheatherManager = ClimateManeger()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func searchButtonPresed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityName = textField.text{
            wheatherManager.fetchWheather(cityName: cityName)

        }
        
        searchTextField.text = ""

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""
        {
            return true
        }else{
            textField.placeholder = "Type something..."
            return false
        }
    }

}

