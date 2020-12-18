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
            print(error.localizedDescription)
        }
    }
}