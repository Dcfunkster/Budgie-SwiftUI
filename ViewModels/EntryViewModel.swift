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
    func create(linkingParentCategory: LinkingObjects<CategoryDB>, parentCategoryDB: CategoryDB, date: Date, deltaMoney: Double, linkingParentVendor: LinkingObjects<VendorDB>, parentVendorDB: VendorDB, descriptor: String?) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let entryDB = EntryDB()
            entryDB.id = UUID().hashValue
            entryDB.parentCategory = linkingParentCategory
            entryDB.date = date
            entryDB.deltaMoney = deltaMoney
            entryDB.parentVendor = linkingParentVendor
            entryDB.descriptor = descriptor
            
            try realm.write {
                //realm.add(entryDB)
                parentCategoryDB.entries.append(entryDB)
                parentVendorDB.entries.append(entryDB)
            }
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
    }
}
