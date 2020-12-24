//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift
import UIKit

class Category: Identifiable, ObservableObject {
    
    // The category object that is more usable for our code
    @Published var id: Int
    @Published var name: String
    @Published var descriptor: String?
    @Published var moneySpentThisPeriod: Double
    @Published var colour: UIColor
    @Published var entries: List<EntryDB>?
    
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
