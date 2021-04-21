//
//  ClimateManeger.swift
//  Climate
//
//  Created by Minna on 14/04/21.
//

import Foundation
import CoreLocation

struct ClimateManeger {
   let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=b8d6c9ded240f1a1f76e534bba8077fd&units=metric"
    var delegate : ClimateManegerDelegate?
    
    func fetchWheather(cityName:String) {
        let url = "\(urlString)&q=\(cityName)"
        print(url)
        
        perfoamRequeste(urlstring: url)
    }
    
    func fetchWheather(with lattitude : CLLocationDegrees, and longitude: CLLocationDegrees){
        let url = "\(urlString)&lat=\(lattitude)&lon=\(longitude)"
        print(url)
        perfoamRequeste(urlstring: url)

    }
    
    func perfoamRequeste(urlstring:String){
        
        if let url = URL(string: urlstring){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    delegate?.didUpdateWithError(error: error!)

                    return
                }
                
                if let safeData = data{
                    
                    
                    if let weathermodel = parseJoson(weatherDate: safeData){
                        
                        delegate?.didUpdateWeather(self, weather: weathermodel)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    
    func parseJoson(weatherDate: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        do {
          let data =  try   decoder.decode(WheatherData.self, from: weatherDate)

            print(data.weather[0].id)
            let cityName = data.name
            let temparature = data.main.temp
            let conditionId = data.weather[0].id
            
            let weatherModel = WeatherModel(cityName: cityName, conditionId: conditionId, temperature: temparature)
            print(weatherModel.conditionName)
            print(weatherModel.tempString)
return weatherModel
            
        } catch {
            print(error)
            delegate?.didUpdateWithError(error: error)

            return nil
        }
    }
}

protocol ClimateManegerDelegate {
    func didUpdateWeather(_ climateManeger : ClimateManeger, weather: WeatherModel)
    func didUpdateWithError(error: Error)

}

