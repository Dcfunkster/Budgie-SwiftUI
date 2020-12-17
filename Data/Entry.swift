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
    
    @objc dynamic var testCategory: Category?
    @objc dynamic var date: Date = Date()
    @objc dynamic var deltaMoney: Double = 0.0
    @objc dynamic var vendor: Vendor?
    @objc dynamic var descriptor: String?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "entries")
}
