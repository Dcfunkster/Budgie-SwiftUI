//
//  EntryForm.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import UIKit
import RealmSwift

//class EntryForm: ObservableObject, Equatable {
//
//    // The items that will be presented on the add entry form
//    @Published var accountSelection: Int = 0
////    @Published var parentCategory = LinkingObjects(fromType: CategoryDB.self, property: "entries")
////    @Published var parentVendor = LinkingObjects(fromType: VendorDB.self, property: "entries")
//    @Published var date = Date()
//    @Published var deltaMoney = 0.0
//    @Published var descriptor = ""
//
//    var entryID: Int?
//
//    var updating: Bool {
//        entryID != nil
//    }
//
//    init() { }
//
//    init(_ entry: Entry) {
//        accountSelection = entry.accountSelection
////        parentCategory = entry.linkingCategory
////        parentVendor = entry.linkingVendor
//        date = entry.date
//        deltaMoney = entry.deltaMoney
//        descriptor = entry.descriptor!
//        entryID = entry.id
//    }
//
//    // comparison operator modifier to be able to compare properties of Entry to each other
//    static func == (lhs: EntryForm, rhs: EntryForm) -> Bool {
//        return lhs.accountSelection == rhs.accountSelection
//    }
//}
