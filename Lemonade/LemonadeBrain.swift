//
//  LemonadeBrain.swift
//  Lemonade
//
//  Created by Stephen Figart on 10/19/14.
//  Copyright (c) 2014 Stephen Figart. All rights reserved.
//

import Foundation

class LemonadeBrain {
    
    class func computeEarnings(data:GameData) -> GameData {
     
        var paidCustomers = 0
        var notPaidCustomers = 0
        
        // iterate customers
        for customer in data.customers {
            // compare to lemonade ratio
            if compareTastePreference(customer, lemonadeRatio: data.lemonadeRatio()) {
                paidCustomers += 1
                println("Paid: \(customer.tastePreference)")
            } else {
                notPaidCustomers += 1
                println("No match, No Revenue: \(customer.tastePreference)")
            }
        }
        
        return computeNewDayBalance(data, paidCustomers: paidCustomers)
    }
    
    class func computeNewDayBalance(data:GameData, paidCustomers:Int) -> GameData {
        // Compute moneyOnHand
        let lemonsCost = data.lemonsPurchased * data.costOfLemons
        let iceCubesCost = data.iceCubesPurchased * data.costOfIceCubes
        
        let newLemonsOnHand = (data.lemonsOnHand + data.lemonsPurchased) - data.lemonsToMix
        let newIceCubesOnHand = (data.iceCubesOnHand + data.iceCubesPurchased) - data.iceCubesToMix
        
        var revenue = paidCustomers * 1 // 1 is how much they paid
        var newMoneyOnHand = data.moneyOnHand - (lemonsCost + iceCubesCost) + revenue
        
        var newData = GameData()
        newData.moneyOnHand = newMoneyOnHand
        newData.lemonsOnHand = newLemonsOnHand
        newData.iceCubesOnHand = newIceCubesOnHand
        return newData
    }
    
    class func compareTastePreference(customer:Customer, lemonadeRatio:Double) -> Bool {
        switch customer.tastePreference {
        case (0.0...0.39):
            println("0...0.39")

            // Acidic Lemonade
            if lemonadeRatio > 1 {
                return true
            } else {
                return false
            }
            
        case (0.4...0.59):
            println("0.4...0.59")
            
            // Equal portioned lemonade
            if lemonadeRatio == 1 {
                return true
            } else {
                return false
            }
            
        case (0.6...1):
            println("0.6...1")
            
            // Diluted lemonade
            if lemonadeRatio < 1 {
                return true
            } else {
                return false
            }
        
        default:
            println("Error: preference is out of range - \(customer.tastePreference)")
        }
        
        return false
    }
}