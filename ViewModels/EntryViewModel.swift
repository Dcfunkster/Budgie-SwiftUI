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
    func create(parentCategory: LinkingObjects<CategoryDB>, date: Date, deltaMoney: Double, vendor: Vendor?, descriptor: String?) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let entryDB = EntryDB()
            entryDB.id = UUID().hashValue
            entryDB.parentCategory = parentCategory
            entryDB.date = date
            entryDB.deltaMoney = deltaMoney
            entryDB.vendor = vendor
            entryDB.descriptor = descriptor
            
            try realm.write {
                realm.add(entryDB)
            }
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
    }
}
