//
//  ViewController.swift
//  Lemonade
//
//  Created by Stephen Figart on 10/17/14.
//  Copyright (c) 2014 Stephen Figart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyOnHandLabel: UILabel!
    @IBOutlet weak var lemonsOnHandLabel: UILabel!
    @IBOutlet weak var iceCubesOnHandLabel: UILabel!
    
    @IBOutlet weak var lemonsPurchasedLabel: UILabel!
    @IBOutlet weak var iceCubesPurchasedLabel: UILabel!
    
    @IBOutlet weak var lemonsMixedLabel: UILabel!
    @IBOutlet weak var iceCubesMixedLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!

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
    
    var data:GameData = GameData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeLemonadeStand()
        updateMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeLemonadeStand() {
        moneyOnHand = 10
        lemonsOnHand = 1
        iceCubesOnHand = 1
        
        println("moneyOnHand: \(moneyOnHand)")
        println("lemonsOnHand: \(lemonsOnHand)")
        println("iceCubesOnHand: \(iceCubesOnHand)")
    }

    // Step 1 Actions
    @IBAction func purchaseLemonsPlusPressed(sender: AnyObject) {
        println("purchaseLemonsPlusPressed")
        if canPurchase(data.costOfLemons) {
            lemonsPurchased += 1
            updateMainView()
        } else {
            showAlertWithText(header: "Purchase Error", message: "Not enough money to purchase lemons")
        }
    }
    @IBAction func purchaseLemonsMinusPressed(sender: AnyObject) {
        println("purchaseLemonsMinusPressed")
        
        if lemonsToMix <= (lemonsOnHand + lemonsPurchased - 1) {
            lemonsPurchased -= 1
            if lemonsPurchased < 0 {
                lemonsPurchased = 0
            }
            updateMainView()
        } else {
            showAlertWithText(header: "Return Purchase Error", message: "Lemons already used in mix")
        }
        

    }
    @IBAction func purchaseIceCubesPlusPressed(sender: AnyObject) {
        println("purchaseIceCubesPlusPressed")
        if canPurchase(data.costOfIceCubes) {
            iceCubesPurchased += 1
            updateMainView()
        } else {
            showAlertWithText(header: "Purchase Error", message: "Not enough money to purchase ice cubes")
        }
    }
    @IBAction func purchaseIceCubesMinusPressed(sender: AnyObject) {
        println("purchaseIceCubesMinusPressed")
        
        if iceCubesToMix <= (iceCubesOnHand + iceCubesPurchased - 1) {
            iceCubesPurchased -= 1
            if iceCubesPurchased < 0 {
                iceCubesPurchased = 0
            }
            updateMainView()
        } else {
            showAlertWithText(header: "Return Purchase Error", message: "Ice cubes already used in mix")
        }
    }
    
    // Step 2 Actions
    @IBAction func mixLemonsPlusPressed(sender: AnyObject) {
        println("mixLemonsPlusPressed")
        if (lemonsOnHand + lemonsPurchased) - (lemonsToMix) >= 1 {
            lemonsToMix += 1
            updateMainView()
        } else {
            showAlertWithText(header: "Mix Error", message: "Not enough lemons")
        }
    }
    @IBAction func mixLemonsMinusPressed(sender: AnyObject) {
        println("mixLemonsMinusPressed")
        lemonsToMix -= 1
        if lemonsToMix < 0 {
            lemonsToMix = 0
        }
        updateMainView()
    }
    @IBAction func mixIceCubesPlusPressed(sender: AnyObject) {
        println("mixIceCubesPlusPressed")
        if (iceCubesOnHand + iceCubesPurchased) - (iceCubesToMix) >= 1 {
            iceCubesToMix += 1
            updateMainView()
        } else {
            showAlertWithText(header: "Mix Error", message: "Not enough ice cubes")
        }
    }
    @IBAction func mixIceCubesMinusPressed(sender: AnyObject) {
        println("mixIceCubesMinusPressed")
        iceCubesToMix -= 1
        if iceCubesToMix < 0 {
            iceCubesToMix = 0
        }
        updateMainView()
    }
    
    // Step 3 Actions
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        println("startDayButtonPressed")
        
        if lemonsToMix == 0 && iceCubesToMix == 0 {
            showAlertWithText(header: "Mix Error", message: "Need to use at least 1 lemon or ice cube")
            return
        }

        // Save Game Data
        data.moneyOnHand = self.moneyOnHand
        data.lemonsOnHand = self.lemonsOnHand
        data.iceCubesOnHand = self.iceCubesOnHand
        data.lemonsPurchased = self.lemonsPurchased
        data.iceCubesPurchased = self.iceCubesPurchased
        data.lemonsToMix = self.lemonsToMix
        data.iceCubesToMix = self.iceCubesToMix
        
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10))) + 1 // returns 1 to 10
        
        // Add weather variable
        if data.weather.value == 0 {
            // Cold
            numberOfCustomers -= 3
            if numberOfCustomers < 0 {
                numberOfCustomers = 1
            }
        } else if data.weather.value == 2 {
            // Warm
            numberOfCustomers += 4
        }
        
        data.customers = CustomerFactory.createCustomers(numberOfCustomers)        
        data.printState()
        
        var newData = LemonadeBrain.computeEarnings(data)
        newData.printState()
        
        // Update UI with new data
        if newData.moneyOnHand > 0 {
            data = newData
            updateLocalVariables(data)
            updateMainView()
            showAlertWithText(header: "Winner", message: "You made money!!")
        } else {
            showAlertWithText(header: "Game Over", message: "Didn't make enough money :(")
        }
    }
    
    func updateLocalVariables(data:GameData) {
        moneyOnHand = data.moneyOnHand
        lemonsOnHand = data.lemonsOnHand
        iceCubesOnHand = data.iceCubesOnHand
        
        lemonsPurchased = 0
        iceCubesPurchased = 0
        
        lemonsToMix = 0
        iceCubesToMix = 0
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateMainView() {
        moneyOnHandLabel.text = "\(moneyOnHand) Dollars"
        lemonsOnHandLabel.text = "\(lemonsOnHand) Lemons"
        iceCubesOnHandLabel.text = "\(iceCubesOnHand) Ice Cubes"

        lemonsPurchasedLabel.text = "\(lemonsPurchased)"
        iceCubesPurchasedLabel.text = "\(iceCubesPurchased)"
        
        lemonsMixedLabel.text = "\(lemonsToMix)"
        iceCubesMixedLabel.text = "\(iceCubesToMix)"
        
        weatherImage.image = data.weather.image
        weatherStatusLabel.text = data.weather.status
        
        println("weather: \(data.weather.value)")
    }
    
    func canPurchase(price:Int) -> Bool {
        // Test enough moneyOnHand to Purchase
        // check lemons purchased
        // check icecubes purchased
        var purchases = (lemonsPurchased * data.costOfLemons) + (iceCubesPurchased * data.costOfIceCubes)
        var result = moneyOnHand - purchases >= price ? true : false
        return result
    }
}

