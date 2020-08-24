//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct Category {
    
    let name: String
    let description: String
    let moneySpentThisPeriod: Decimal
    let colour: Color
    
}

let testData = [Category(name: "Gas", description: "Money spent on filling a tank for gas that I've used", moneySpentThisPeriod: 50, colour: Color.yellow),
                Category(name: "Eating Out", description: "Money spent on eating in restaurants or ordering food from one", moneySpentThisPeriod: 23.65, colour: Color.red),
                Category(name: "Car Repairs", description: "Money spent repairing or upgrading my vehicle", moneySpentThisPeriod: 125.69, colour: Color.green)]
