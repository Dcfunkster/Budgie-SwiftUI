//
//  AddCategory.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct AddVendor: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var vendorModel: VendorViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    @ObservedObject var form: VendorForm
    var selectedVendor: Vendor
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Superstore", text: $form.name)
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
                            deleteVendor(vendorID: form.vendorID!)
                        })
                        .foregroundColor(.red)
                    }
                }
                Section {
                    if form.updating {
                        Text("Recent Entries")
                        ForEach(entryModel.entries.filter({ $0.linkingVendor.first == selectedVendor })) { e in
                            Text("\(e.linkingVendor.first!.name)")
                        }
                    }
                }
            }
            .navigationBarTitle(form.updating ? form.name : "New Vendor")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { self.isPresented.toggle() })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(form.updating ? "Update" : "Save", action: form.updating ? updateVendor : saveVendor)
                }
            })
        }
    }
}

//MARK: - Actions
extension AddVendor {
    // Need to remove the vendor from the model and the created parentVendors becuase if only the model is changed, the form doesn't update
    func updateVendor() {
        if let vendorID = form.vendorID {
            vendorModel.update(vendorID: vendorID, name: form.name, descriptor: form.descriptor)
            self.isPresented.toggle()
        }
    }
    
    func saveVendor() {
        vendorModel.create(name: form.name, descriptor: form.descriptor)
        self.isPresented.toggle()
    }
    
    func deleteVendor(vendorID: Int) {
        vendorModel.delete(vendorID: vendorID)
        self.isPresented.toggle()
    }
}
