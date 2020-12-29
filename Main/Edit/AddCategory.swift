//
//  AddCategory.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct AddCategory: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    
    @ObservedObject var form: CategoryForm
    
    @State var categories: [Category]
    
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
                    if form.updating {
                        Button("Delete", action: {
                            deleteCategory(categoryID: form.categoryID!)
                        })
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
    func updateCategory() {
        if let categoryID = form.categoryID {
            categoryModel.update(categoryID: categoryID, name: form.name, descriptor: form.descriptor)
            dismiss()
        }
    }
    func saveCategory() {
        categoryModel.create(name: form.name, descriptor: form.descriptor)
        categories.append(categoryModel.categories.last!)
        dismiss()
    }
    func deleteCategory(categoryID: Int) {
        categoryModel.delete(categoryID: categoryID)
        //categories.remove(at: <#T##Int#>)
        dismiss()
    }
}
