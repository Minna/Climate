//
//  ClimateManeger.swift
//  Climate
//
//  Created by Minna on 14/04/21.
//

import Foundation

struct ClimateManeger {
   let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=b8d6c9ded240f1a1f76e534bba8077fd&units=metric"
    func fetchWheather(cityName:String) {
        let url = "\(urlString)&q=\(cityName)"
        print(url)
        
        perfoamRequeste(urlstring: url)
    }
    
    func perfoamRequeste(urlstring:String){
        
        if let url = URL(string: urlstring){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    
                    
                    parseJoson(weatherDate: safeData)
                    
                }
            }
            task.resume()
            
        }
    }
    
    func parseJoson(weatherDate: Data){
        
        let decoder = JSONDecoder()
        do {
          let data =  try   decoder.decode(WheatherData.self, from: weatherDate)

            print(data.weather[0].id)
            getWeatherConditionName(for:data.weather[0].id)
        } catch {
            print(error)
        }
    }
    func getWeatherConditionName(for id: Int) -> String {
        
        switch id {
        case 200...232:
                   return "cloud.bolt"
               case 300...321:
                   return "cloud.drizzle"
               case 500...531:
                   return "cloud.rain"
               case 600...622:
                   return "cloud.snow"
               case 701...781:
                   return "cloud.fog"
               case 800:
                   return "sun.max"
               case 801...804:
                   return "cloud.bolt"
               default:
                   return "cloud"
               }

        }
    }
}
