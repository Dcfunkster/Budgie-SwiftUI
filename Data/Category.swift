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
    let id: Int
    let name: String
    let descriptor: String?
    let moneySpentThisPeriod: Double
    let colour: UIColor
    let entries: List<Entry>?
    
    init(categoryDB: CategoryDB) {
        id = categoryDB.id
        name = categoryDB.name
        descriptor = categoryDB.descriptor
        moneySpentThisPeriod = categoryDB.moneySpentThisPeriod
        entries = categoryDB.entries
        colour = categoryDB.colour
    }
}
