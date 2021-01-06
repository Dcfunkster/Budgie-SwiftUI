//
//  EntryViewModel.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import RealmSwift

final class EntryViewModel: ObservableObject {
    private var entryResults: Results<EntryDB>
    
    init(realm: Realm) {
        entryResults = realm.objects(EntryDB.self)
    }
    
    var entries: [Entry] {
        entryResults.map(Entry.init)
    }
}

//MARK: - CRUD Actions
extension EntryViewModel {
    // should be phrased as an update to the category instead of a creation
    func create(accountSelection: Int,
                linkingParentCategory: LinkingObjects<CategoryDB>,
                categoryDB: CategoryDB,
                date: Date,
                deltaMoney: Double,
                linkingParentVendor: LinkingObjects<VendorDB>,
                vendorDB: VendorDB,
                descriptor: String?) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let entryDB = EntryDB()
            entryDB.accountSelection = accountSelection
            entryDB.id = UUID().hashValue
            entryDB.linkingCategory = linkingParentCategory
            entryDB.category = categoryDB
            entryDB.date = date
            entryDB.deltaMoney = deltaMoney
            entryDB.linkingVendor = linkingParentVendor
            entryDB.vendor = vendorDB
            entryDB.descriptor = descriptor
            
            try realm.write {
                categoryDB.entries.append(entryDB)
                vendorDB.entries.append(entryDB)
            }
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
    }
}
