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
    
    @ObservedObject var form: CategoryForm
    
    @Binding var parentCategories: [Category]
    
    @State var entries: RealmSwift.List<EntryDB>?
    
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
                Section {
                    if form.updating {
                        Button("Delete", action: {
                            deleteCategory(categoryID: form.categoryID!)
                        })
                        .foregroundColor(.red)
                    }
                }
                Section {
                    if form.updating {
                        Text("Recent Entries")
                        ForEach(0..<entries!.count) {
                            Text(entries![$0].vendor!.name)
                        }
                    }
                }
            }
            .navigationBarTitle(form.updating ? form.name : "New Category")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(form.updating ? "Update" : "Save", action: form.updating ? updateCategory : saveCategory)
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
            categoryModel.update(categoryID: categoryID, name: form.name, descriptor: form.descriptor)
            
            // Also update the same category from parentCategories
            let index = parentCategories.firstIndex { $0.id == categoryID }
            let oldCategory = parentCategories[index!]
            oldCategory.name = form.name
            oldCategory.descriptor = form.descriptor
            dismiss()
        }
    }
    
    func saveCategory() {
        categoryModel.create(name: form.name, descriptor: form.descriptor)
        
        // Also add the category to parentCategories
        parentCategories.append(categoryModel.categories.first(where: {
            $0.name == form.name
        })!)
        dismiss()
    }
    
    func deleteCategory(categoryID: Int) {
        categoryModel.delete(categoryID: categoryID)
        
        // Also delete the category from parentCategories
        let index = parentCategories.firstIndex { $0.id == categoryID }
        parentCategories.remove(at: index!)
        dismiss()
    }
}
