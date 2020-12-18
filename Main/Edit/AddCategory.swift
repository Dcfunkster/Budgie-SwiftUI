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
                    Button("Add", action: saveCategory)
                }
                .navigationBarTitle("Add Category", displayMode: .inline)
            }
        }
    }
}

//MARK: - Actions
extension AddCategory {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    func saveCategory() {
        categoryModel.create(name: form.name, descriptor: form.descriptor)
        dismiss()
    }
    
    //func load() {
    //    categoryListItems = realm.objects(Category.self)
    //}
}
