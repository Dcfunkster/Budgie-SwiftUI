//
//  Entry.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

/// A single purchase/payment entered into the database

import Foundation
import RealmSwift

class Entry: Object {
    
    dynamic var testCategory: Category? = nil
    dynamic var date: Date = Date()
    dynamic var deltaMoney: Decimal = 0.0
    dynamic var vendor: Vendor? = nil
    dynamic var descriptor: String? = nil
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "entries")
}
