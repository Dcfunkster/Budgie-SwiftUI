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
    
    @State private var catPickerSelection: Int = 0 // The selected category's id
    @State private var vendorPickerselection: Int = 0
    @State private var spendFromSavings = false
    @State private var categoryEntries: Results<EntryDB>?
    @State private var selectedCategory: Category?
    @State private var selectedVendor: Vendor?
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    @EnvironmentObject var vendorModel: VendorViewModel
    
    @ObservedObject var form: EntryForm
    @ObservedObject var amount = NumbersOnly()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State private var activeCategories = [Category]()
    
    var body: some View {
        Form {
            
            Section {
                Picker("Account Selection", selection: $form.accountSelection) {
                    Text("Spend").tag(0)
                    Text("Save").tag(1)
                    Text("Income").tag(2) // TODO: Different form for PAYDAY
                }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: form.accountSelection) { _ in
                    poplulateCategoryList()
                }
                .onAppear {
                    poplulateCategoryList()
                }
                
                if form.accountSelection == 0 {
                    Toggle("Spend from Savings", isOn: $spendFromSavings)
                }
            }
                
            Section {
                
                Picker("Category", selection: $catPickerSelection) {
                    ForEach(activeCategories.sorted(by: { $0.name < $1.name } )) { i in
                        VStack {
                            Text(i.name)
                                .bold()
                            if i.descriptor != "" { // only show descriptor if there it is populated
                                Text(i.descriptor!)
                                    .italic()
                            }
                        }
                    }
                }
                
                if form.accountSelection == 0 || form.accountSelection == 2 {
                    Picker("Vendor", selection: $vendorPickerselection) {
                        ForEach(vendorModel.vendors.sorted(by: { $0.name < $1.name })) { i in
                            Text(i.name)
                        }
                    }
                }
                
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
                
                HStack {
                    Text("Description")
                    TextField("E.g. Lunch with friends", text: $form.descriptor)
                        .multilineTextAlignment(.trailing)
                }
            }
            Section {
                Button(action: {
                    form.deltaMoney = (amount.value as NSString).doubleValue // downcasts to NSString and converts that to double
//                    loadItems()
                    saveItems()
                    self.hideKeyboard()
                }, label: { Text("Add Entry") })
            }
        }
    }
}


//MARK: - Actions

extension AddView {
    func saveItems() {
        selectedCategory = realm.objects(Category.self).filter { $0.id == catPickerSelection }.first
        selectedVendor = realm.objects(Vendor.self).filter { $0.id == vendorPickerselection }.first
        
        let newEntry = EntryDB(value: [
                                "id": UUID().hashValue,
                                "date": form.date,
                                "deltaMoney": (form.accountSelection == 0 || form.accountSelection == 1) ? -form.deltaMoney : form.deltaMoney,
                                "vendor": selectedVendor!, // TODO: make default vendor if no vendor selected
                                "descriptor": form.descriptor])
        
        categoryModel.update(accountSelection: selectedCategory!.accountSelection,
                             categoryID: selectedCategory!.id,
                             name: selectedCategory!.name,
                             descriptor: selectedCategory!.descriptor!,
                             entries: selectedCategory!.entries,
                             newEntry: newEntry)
//        vendorModel.update(vendorID: selectedVendor!.id, name: selectedVendor!.name, descriptor: selectedVendor!.descriptor!, entries: selectedVendor!.entries, newEntry: newEntry)

    }
    
    func poplulateCategoryList() {
        activeCategories = [Category]()
        categoryModel.categories.forEach {
            if form.accountSelection == $0.accountSelection {
                activeCategories.append($0)
            }
        }
    }
    
//    func loadItems() {
//        // finds the category with the id inputted into catPickerSelection from the picker
//        selectedCategory = categories.filter{ $0.id == catPickerSelection }.first
//        categoryEntries = selectedCategory?.entries?.sorted(byKeyPath: "date", ascending: true)
//    }
}

// adds functionality to self to easily dismiss keyboard using self.hideKeyboard()
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
