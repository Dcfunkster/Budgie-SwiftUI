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
    var entries: Results<EntryDB>
    
    init(realm: Realm) {
        entries = realm.objects(EntryDB.self)
    }
    
}

//MARK: - CRUD Actions
extension EntryViewModel {
    // should be phrased as an update to the category instead of a creation
    func create(accountSelection: Int,
                linkingParentCategory: LinkingObjects<Category>,
                categoryDB: Category,
                date: Date,
                deltaMoney: Double,
                linkingParentVendor: LinkingObjects<Vendor>,
                vendorDB: Vendor,
                descriptor: String?) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let entryDB = EntryDB()
            entryDB.accountSelection = accountSelection
            entryDB.id = UUID().hashValue
            entryDB.linkingCategory = linkingParentCategory
            entryDB.date = date
            entryDB.deltaMoney = deltaMoney
            entryDB.linkingVendor = linkingParentVendor
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
