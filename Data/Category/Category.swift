//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift
import UIKit

class Category: Identifiable {
    
    // The category object that is more usable for our code
    let id: Int
    let name: String
    let descriptor: String?
    let moneySpentThisPeriod: Double
    let colour: UIColor
    let entries: List<EntryDB>?
    
    // Convenience initializer
    init(categoryDB: CategoryDB) {
        id = categoryDB.id
        name = categoryDB.name
        descriptor = categoryDB.descriptor
        moneySpentThisPeriod = categoryDB.moneySpentThisPeriod
        entries = categoryDB.entries
        colour = categoryDB.colour
    }
}
