//
//  AddView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct AddView: View {
    
    @State private var catPickerSelection = 0
    @State private var vendorPickerselection = 0
    @State private var categoryEntries: Results<EntryDB>?
    @State private var vendors: Results<Vendor>?
    @State private var selectedCategory: Category?
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    @ObservedObject var form: EntryForm
    @ObservedObject var amount = NumbersOnly()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    let categories: [Category]
    
    // TODO: use the list of all categories and find the index of selection using the int given by the picker
    var body: some View {
        Form {
            Section {
                Picker(selection: $catPickerSelection, label: Text("Category")) {
                    ForEach(categories) { category in
                        VStack {
                            Text(category.name)
                            Text(category.descriptor!)
                        }
                    }
                }
                Text(selectedCategory?.name ?? "No category selected")
                DatePicker(selection: $form.date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
                
                HStack {
                    Text("Amount ($)")
                    Spacer()
                    TextField("E.g. 5.67", text: $amount.value) // TODO: work this into $form.deltaMoney
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                
                Picker(selection: $vendorPickerselection, label: Text("Vendor")) {
                    ForEach(0..<(vendors?.count ?? 1)) { _ in
                        Text("")
                    }
                }
                
                HStack {
                    Text("Description")
                    TextField("E.g. Lunch with friends", text: $form.descriptor)
                        .multilineTextAlignment(.trailing)
                }
            }
            Section {
                Button(action: {
                    selectedCategory = categoryModel.categories[catPickerSelection]
                    loadItems()
//                    //newEntry.vendor = vendor -also need a list of vendors stored in db
                    self.hideKeyboard()
                }, label: {Text("Add Entry")})
            }
        }
    }
}


//MARK: - Actions

extension AddView {
    func saveItems() {
        entryModel.create(parentCategory: form.parentCategory, date: form.date, deltaMoney: form.deltaMoney, vendor: form.vendor, descriptor: form.descriptor)
    }
    func loadItems() {
        categoryEntries = selectedCategory?.entries?.sorted(byKeyPath: "date", ascending: true)
    }
}

// adds functionality to self to easily dismiss keyboard using self.hideKeyboard()
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
