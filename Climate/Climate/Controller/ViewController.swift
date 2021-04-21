//
//  ViewController.swift
//  Climate
//
//  Created by Minna on 13/04/21.
//

import UIKit
import CoreLocation

class WheatherViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
   
    
    var wheatherManager = ClimateManeger()
    let locationManager = CoreLocation.CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        wheatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        locationManager.requestLocation()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonPresed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
 
    @IBAction func locationMangerButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
   

}

extension WheatherViewController:  UITextFieldDelegate{
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)

        return true
    }

}

extension WheatherViewController:  ClimateManegerDelegate{
    func didUpdateWeather(_ climateManeger: ClimateManeger, weather: WeatherModel) {

        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImage.image = UIImage.init(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            print(weather.cityName)
        }

      
    }
    
    func didUpdateWithError(error: Error) {
        
    }
   
}

extension WheatherViewController:  CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
            if let location = locations.last {
            print(location)
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                locationManager.stopUpdatingLocation()

                wheatherManager.fetchWheather(with: lat, and: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


