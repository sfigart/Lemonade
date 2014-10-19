//
//  CustomerFactory.swift
//  Lemonade
//
//  Created by Stephen Figart on 10/19/14.
//  Copyright (c) 2014 Stephen Figart. All rights reserved.
//

import Foundation

class CustomerFactory {
    class func createCustomers(numberOfCustomers:Int) -> [Customer] {
        var customers:[Customer] = []

        for var x = 0; x < numberOfCustomers; x++ {
            customers.append(createCustomer())
        }
        return customers
    }
    
    class func createCustomer() -> Customer {
        var customer = Customer()
        customer.tastePreference = generateRandomNumber()
        return customer
    }
    
    // Returns 0.0 to 0.9
    class func generateRandomNumber() -> Double {
        let randomNumber = Double(arc4random_uniform(UInt32(10))) * 0.1
        return randomNumber
    }
}