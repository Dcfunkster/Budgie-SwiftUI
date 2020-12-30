//
//  CategoryViewModel.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import RealmSwift

final class CategoryViewModel: ObservableObject {
    private var categoryResults: Results<CategoryDB>
    
    init(realm: Realm) {
        categoryResults = realm.objects(CategoryDB.self)
    }
    
    // maps the Results<Category> onto a normal more usable array
    var categories: [Category] {
        categoryResults.map(Category.init)
    }
}

//MARK: - CRUD Actions
extension CategoryViewModel {
    func create(name: String, descriptor: String) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let categoryDB = CategoryDB()
            categoryDB.id = UUID().hashValue
            categoryDB.name = name
            categoryDB.descriptor = descriptor
            
            try realm.write {
                realm.add(categoryDB)
            }
        } catch {
            // Handle error
            print("Error creating new category, \(error.localizedDescription)")
        }
    }
    
    func update(categoryID: Int, name: String, descriptor: String) {
        objectWillChange.send()
        
        do {
            let realm = try! Realm()
            try realm.write {
                realm.create(CategoryDB.self,
                             value: [
                                "id": categoryID,
                                "name": name,
                                "descriptor": descriptor],
                             update: .modified)
            }
        } catch {
            print("Error updating category, \(error.localizedDescription)")
        }
    }
    
    // Add entry to category
    func update(categoryID: Int, name: String, descriptor: String, entries: List<EntryDB>, newEntry: EntryDB) {
        objectWillChange.send()
        
        let appendedEntries = RealmSwift.List<EntryDB>()
        entries.forEach {
            appendedEntries.append($0)
        }
        appendedEntries.append(newEntry)
        
        
        do {
            let realm = try! Realm()
            try realm.write {
                realm.create(CategoryDB.self,
                             value: [
                                "id": categoryID,
                                "name": name,
                                "descriptor": descriptor,
                                "entries": appendedEntries],
                             update: .modified)
            }
        } catch {
            print("Error adding entry to category, \(error.localizedDescription)")
        }
    }
    
    func delete(categoryID: Int) {
        objectWillChange.send()
        
        guard let categoryDB = categoryResults.first(
            where: { $0.id == categoryID })
        else { return }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(categoryDB)
            }
        } catch {
            print("Error deleting category, \(error.localizedDescription)")
        }
    }
}
