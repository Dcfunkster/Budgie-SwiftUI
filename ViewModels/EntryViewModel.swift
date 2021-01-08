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
    var entries: Results<Entry>
    
    init(realm: Realm) {
        entries = realm.objects(Entry.self)
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
            
            let entry = Entry()
            entry.accountSelection = accountSelection
            entry.id = UUID().hashValue
            entry.linkingCategory = linkingParentCategory
            entry.date = date
            entry.deltaMoney = deltaMoney
            entry.linkingVendor = linkingParentVendor
            entry.descriptor = descriptor
            
            try realm.write {
                categoryDB.entries.append(entry)
                vendorDB.entries.append(entry)
            }
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
    }
}
