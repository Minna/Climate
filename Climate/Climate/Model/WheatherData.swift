//
//  WheatherData.swift
//  Climate
//
//  Created by Minna on 17/04/21.
//

import Foundation

struct WheatherData  : Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Decodable{
    let temp: Double
}
struct Weather : Decodable{
    let id: Int
}
