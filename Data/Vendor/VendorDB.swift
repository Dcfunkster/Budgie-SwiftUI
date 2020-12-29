//
//  Vendor.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift
import UIKit

class VendorDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descriptor: String? = nil
    @objc dynamic var colour: UIColor = UIColor.white
    
    let entries = RealmSwift.List<EntryDB>()
    
    override static func ignoredProperties() -> [String] {
        return ["colour"]
    }
    override static func primaryKey() -> String? {
        "id"
    }
}
