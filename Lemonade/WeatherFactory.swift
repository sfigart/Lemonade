//
//  WeatherFactory.swift
//  Lemonade
//
//  Created by Stephen Figart on 10/19/14.
//  Copyright (c) 2014 Stephen Figart. All rights reserved.
//

import Foundation
import UIKit

class WeatherFactory {
    
    class func getWeather() -> Weather {
        let weatherConditionsCount = 3
        let randomNumber = Int(arc4random_uniform(UInt32(weatherConditionsCount)))
        
        var weather = Weather()
        weather.value = randomNumber
        
        switch weather.value {
        case 0:
            weather.status = "Cold"
            weather.image = UIImage(named: "Cold")
        case 1:
            weather.status = "Mild"
            weather.image = UIImage(named: "Mild")
        case 2:
            weather.status = "Warm"
            weather.image = UIImage(named: "warm")
        default:
            weather.status = "Cold"
            weather.image = UIImage(named: "Cold")
        }
        
        println("weatherFactory: \(weather.status)")
        return weather
    }
}