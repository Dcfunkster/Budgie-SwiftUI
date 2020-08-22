//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation

struct Category {
    
    let name: String
    let description: String
    let moneySpentThisPeriod: Decimal
    
}

let testData = [Category(name: "McDonald's", description: "Restaurant", moneySpentThisPeriod: 0.0),
                Category(name: "Tim Hortons", description: "Restaurant", moneySpentThisPeriod: 0.0),
                Category(name: "Canadian Tire", description: "Store", moneySpentThisPeriod: 0.0)]
