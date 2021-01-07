//
//  EntryDB.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift

class EntryDB: Object, Identifiable {
    
    // The entry that is readable for Realm
    @objc dynamic var id = 0
    @objc dynamic var date = Date()
    @objc dynamic var deltaMoney: Double = 0.0
    @objc dynamic var descriptor: String?
    @objc dynamic var accountSelection: Int = 0

    
    var linkingCategory = LinkingObjects(fromType: Category.self, property: "entries")
    var linkingVendor = LinkingObjects(fromType: Vendor.self, property: "entries")
}
