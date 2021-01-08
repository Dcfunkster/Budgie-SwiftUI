//
//  AddCategory.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct AddCategory: View {
    
    @Binding var isPresented: Bool
    
//    var selectedCategory: Category
    var accountSelection: Int
    
    // FORM
    @State private var categoryID: Int?
    @State private var name = ""
    @State private var descriptor = ""
    @State private var updating = false
    
    var entries = realm.objects(Entry.self)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Groceries", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Description")
                        Spacer()
                        TextField("Optional", text: $descriptor)
                            .multilineTextAlignment(.trailing)
                    }
                    
    //                HStack {
    //                    Text("Colour")
    //                    Spacer()
    //                    ColorPicker("", selection: $form.colour, supportsOpacity: false) // Want this to eventually automatically choose a colour that the user has not previously selected.
    //                        .multilineTextAlignment(.trailing)
    //                }
                }
                
                // TODO: Make button that lets user change from saving to spending or vv?
                
//                if updating {
//                    Section {
//                        Text("Recent Entries")
//                        ForEach(entries.filter({ $0.linkingCategory.first == selectedCategory })) { e in
//                            Text("\(e.linkingCategory.first!.name)")
//                        }
//                    }
//                }
            }
            .navigationBarTitle(updating ? name :
                                accountSelection == 0 ? "Spending" :
                                accountSelection == 1 ? "Saving" : "Income")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(updating ? "Update" : "Save",
                           action: /*updating ? updateCategory :*/ saveCategory)
                }
            })
        }
    }
}

//MARK: - Actions
extension AddCategory {
    func dismiss() {
        self.isPresented = false
    }
    
    // Need to remove the category from the model and the created parentCategories becuase if only the model is changed, the form doesn't update
//    func updateCategory() {
//        if let categoryID = categoryID {
//
//            do {
//                let realm = try! Realm()
//                try realm.write {
//                    realm.create(Category.self,
//                                 value: [
//                                    "accountSelection": accountSelection,
//                                    "id": categoryID,
//                                    "name": name,
//                                    "descriptor": descriptor],
//                                 update: .modified)
//                }
//            } catch {
//                print("Error updating category, \(error.localizedDescription)")
//            }
//
//            dismiss()
//        }
//    }
    
    func saveCategory() {
        
        do {
            let realm = try Realm()

            let categoryDB = Category()
            categoryDB.accountSelection = accountSelection
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
        
        dismiss()
    }
}
