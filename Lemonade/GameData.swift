//
//  GameData.swift
//  Lemonade
//
//  Created by Stephen Figart on 10/19/14.
//  Copyright (c) 2014 Stephen Figart. All rights reserved.
//

import Foundation

struct GameData {
    let costOfLemons = 2
    let costOfIceCubes = 1
    
    // Weather
    var weather = WeatherFactory.getWeather()
    
    // Money and Supplies
    var moneyOnHand = 0
    var lemonsOnHand = 0
    var iceCubesOnHand = 0
    
    // Purchases
    var lemonsPurchased = 0
    var iceCubesPurchased = 0
    
    // Mix ingredients
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    var customers:[Customer] = []
    
    func printState() {
        println("Game data")
        println("---------")
        println("weather: \(weather.status)")
        println("costOfLemons: \(costOfLemons)")
        println("costOfIceCubes: \(costOfIceCubes)")
        println("Money and Supplies")
        println("moneyOnHand: \(moneyOnHand)")
        println("lemonsOnHand: \(lemonsOnHand)")
        println("iceCubesOnHand: \(iceCubesOnHand)")
        println("\nPurchases")
        println("lemonsPurchased: \(lemonsPurchased)")
        println("iceCubesPurchased: \(iceCubesPurchased)")
        println("Mix Ingredients")
        println("lemonsToMix: \(lemonsToMix)")
        println("iceCubesToMix: \(iceCubesToMix)")
        println("Customers: \(customers.count)")
        for (index, customer) in enumerate(customers) {
            println("\(index): \(customer.tastePreference)")
        }
    }
    
    func lemonadeRatio() -> Double {
        if iceCubesToMix > 0 {
            return Double(lemonsToMix) / Double(iceCubesToMix)
        } else {
            return 0.0
        }
    }
}