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
    @State private var selectedCategory: Category?
    
    @ObservedObject var amount = NumbersOnly()
    
    // FORM
    @State private var accountSelection = 0
    @State private var deltaMoney = 0.0
    @State private var date = Date()
    @State private var descriptor = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var categories = realm.objects(Category.self)
    var vendors = realm.objects(Vendor.self)
    
    var body: some View {
        Form {

            Section {
                Picker("Account Selection", selection: $accountSelection) {
                    Text("Spend").tag(0)
                    Text("Save").tag(1)
                    Text("Income").tag(2) // TODO: Different form for PAYDAY
                }.pickerStyle(SegmentedPickerStyle())

                if accountSelection == 0 {
                    Toggle("Spend from Savings", isOn: $spendFromSavings)
                }
            }

            Section {

                Picker("Category", selection: $catPickerSelection) {
                    ForEach(categories.filter({ $0.accountSelection == accountSelection }).sorted(by: { $0.name < $1.name })) { i in
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

                if accountSelection == 0 || accountSelection == 2 {
                    Picker("Vendor", selection: $vendorPickerselection) {
                        ForEach(vendors.sorted(by: { $0.name < $1.name })) { i in
                            Text(i.name)
                        }
                    }
                }

                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
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
                    TextField("E.g. Lunch with friends", text: $descriptor)
                        .multilineTextAlignment(.trailing)
                }
            }
            Section {
                Button(action: {
                    deltaMoney = (amount.value as NSString).doubleValue // downcasts to NSString and converts that to double
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

        do {
            let realm = try! Realm()
            try realm.write {
                realm.create(Category.self,
                             value: [
                                "accountSelection": selectedCategory!.accountSelection,
                                "id": selectedCategory!.id,
                                "name": selectedCategory!.name,
                                "descriptor": selectedCategory!.descriptor!,
                                "entries": selectedCategory!.entries],
                             update: .modified)
            }
        } catch {
            print("Error adding entry to category, \(error.localizedDescription)")
        }
        
//        vendorModel.update(vendorID: selectedVendor!.id, name: selectedVendor!.name, descriptor: selectedVendor!.descriptor!, entries: selectedVendor!.entries, newEntry: newEntry)

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
