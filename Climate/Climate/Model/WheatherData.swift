//
//  WheatherData.swift
//  Climate
//
//  Created by Minna on 17/04/21.
//

import Foundation

struct WheatherData  : Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Codable{
    let temp: Double
}
struct Weather : Codable{
    let id: Int
}
