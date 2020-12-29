//
//  EntryForm.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import UIKit
import RealmSwift

class EntryForm: ObservableObject {
    // The items that will be presented on the add entry form
    @Published var parentCategory = LinkingObjects(fromType: CategoryDB.self, property: "entries")
    @Published var parentVendor = LinkingObjects(fromType: VendorDB.self, property: "entries")
    @Published var date = Date()
    @Published var deltaMoney: Double = 0.0
    @Published var descriptor = ""
    
    var entryID: Int?
    
    var updating: Bool {
        entryID != nil
    }
    
    init() { }
    
    init(_ entry: Entry) {
        parentCategory = entry.parentCategory
        parentVendor = entry.parentVendor
        date = entry.date
        deltaMoney = entry.deltaMoney
        descriptor = entry.descriptor!
        entryID = entry.id
    }
}
