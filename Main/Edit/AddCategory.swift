//
//  AddCategory.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct AddCategory: View {
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var form: CategoryForm
    
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
                    Button("Delete", action: {
                        deleteCategory(categoryID: form.categoryID!)
                    })
                }
                .navigationBarTitle(form.updating ? form.name : "New Category")
                .navigationBarItems(leading: Button("Cancel", action: dismiss),
                                    trailing: Button(form.updating ? "Update" : "Save", action: form.updating ? updateCategory : saveCategory))
            }
        }
    }
}

//MARK: - Actions
extension AddCategory {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    func updateCategory() {
        if let categoryID = form.categoryID {
            categoryModel.update(categoryID: categoryID, name: form.name, descriptor: form.descriptor)
            dismiss()
        }
    }
    func saveCategory() {
        categoryModel.create(name: form.name, descriptor: form.descriptor)
        dismiss()
    }
    func deleteCategory(categoryID: Int) {
        categoryModel.delete(categoryID: categoryID)
        dismiss()
    }
}
