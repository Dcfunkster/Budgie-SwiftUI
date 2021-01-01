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
    
    let accountSelection: Int
    let id: Int
    let date: Date
    let deltaMoney: Double
    let parentVendor: LinkingObjects<VendorDB>
    let descriptor: String?
    var parentCategory: LinkingObjects<CategoryDB>
    
    // Convenience initializer
    init(entryDB: EntryDB) {
        accountSelection = entryDB.accountSelection
        id = entryDB.id
        date = entryDB.date
        deltaMoney = entryDB.deltaMoney
        parentVendor = entryDB.parentVendor
        descriptor = entryDB.descriptor
        parentCategory = entryDB.parentCategory
    }
}
