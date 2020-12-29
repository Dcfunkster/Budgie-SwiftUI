//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import RealmSwift
import UIKit

class Vendor: Identifiable, ObservableObject {
    
    // The vendor object that is more usable for our code
    @Published var id: Int
    @Published var name: String
    @Published var descriptor: String?
    @Published var colour: UIColor
    @Published var entries: List<EntryDB>?
    
    // Convenience initializer
    init(vendorDB: VendorDB) {
        id = vendorDB.id
        name = vendorDB.name
        descriptor = vendorDB.descriptor
        entries = vendorDB.entries
        colour = vendorDB.colour
    }
}
