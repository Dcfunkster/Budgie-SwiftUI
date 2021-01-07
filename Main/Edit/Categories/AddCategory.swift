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
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    @ObservedObject var form: CategoryForm
    var selectedCategory: Category
    var accountSelection: Int
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Groceries", text: $form.name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Description")
                        Spacer()
                        TextField("Optional", text: $form.descriptor)
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
                
                if form.updating {
                    Section {
                        Text("Recent Entries")
                        ForEach(entryModel.entries.filter({ $0.linkingCategory.first == selectedCategory })) { e in
                            Text("\(e.linkingCategory.first!.name)")
                        }
                    }
                }
            }
            .navigationBarTitle(form.updating ? form.name :
                                accountSelection == 0 ? "Spending" :
                                accountSelection == 1 ? "Saving" : "Income")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(form.updating ? "Update" : "Save",
                           action: form.updating ? updateCategory : saveCategory)
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
    func updateCategory() {
        if let categoryID = form.categoryID {
            categoryModel.update(accountSelection: form.accountSelection,
                                 categoryID: categoryID,
                                 name: form.name,
                                 descriptor: form.descriptor)
            dismiss()
        }
    }
    
    func saveCategory() {
        categoryModel.create(accountSelection: accountSelection, // TODO: throw error if user enters a repeating category name in the same accountSelection
                             name: form.name,
                             descriptor: form.descriptor)
        dismiss()
    }
}
