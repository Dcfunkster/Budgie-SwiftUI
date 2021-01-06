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
    let linkingVendor: LinkingObjects<VendorDB>
    let vendor: VendorDB?
    let descriptor: String?
    var linkingCategory: LinkingObjects<CategoryDB>
    let category: CategoryDB?
    
    // Convenience initializer
    init(entryDB: EntryDB) {
        accountSelection = entryDB.accountSelection
        id = entryDB.id
        date = entryDB.date
        deltaMoney = entryDB.deltaMoney
        linkingVendor = entryDB.linkingVendor
        vendor = entryDB.vendor
        descriptor = entryDB.descriptor
        linkingCategory = entryDB.linkingCategory
        category = entryDB.category
    }
}
