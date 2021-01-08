//
//  CategoryDB.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift

class Category: Object, Identifiable {
    
    // The category object that is readable for Realm
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var descriptor: String?
    @objc dynamic var moneySpentThisPeriod: Double = 0.0
    @objc dynamic var colour: UIColor = UIColor.white
    @objc dynamic var accountSelection = 0
    
    let entries = RealmSwift.List<Entry>()

    override static func ignoredProperties() -> [String] {
        return ["colour"]
    }
    override static func primaryKey() -> String? {
        "id"
    }
}
