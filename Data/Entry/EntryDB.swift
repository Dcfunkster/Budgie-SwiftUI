//
//  EntryDB.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift

class EntryDB: Object {
    
    // The entry that is readable for Realm
    @objc dynamic var id = 0
    @objc dynamic var date = Date()
    @objc dynamic var deltaMoney: Double = 0.0
    @objc dynamic var vendor: Vendor?
    @objc dynamic var descriptor: String?
    
    var parentCategory = LinkingObjects(fromType: CategoryDB.self, property: "entries")
}
