//
//  Entry.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

/// A single purchase/payment entered into the database

import RealmSwift
import UIKit

class Entry: Identifiable {
    
    let id: Int
    let date: Date
    let deltaMoney: Double
    let vendor: Vendor?
    let descriptor: String?
    var parentCategory: LinkingObjects<CategoryDB>
    
    // Convenience initializer
    init(entryDB: EntryDB) {
        id = entryDB.id
        date = entryDB.date
        deltaMoney = entryDB.deltaMoney
        vendor = entryDB.vendor
        descriptor = entryDB.descriptor
        parentCategory = entryDB.parentCategory
    }
}
