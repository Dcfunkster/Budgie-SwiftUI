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
    
    @ObservedObject var form: VendorForm
    
    @Binding var parentVendors: [Vendor]
    
    @State var entries: RealmSwift.List<EntryDB>?
    
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
                        ForEach(0..<entries!.count) {
                            Text(entries![$0].vendor!.name)
                        }
                    }
                }
            }
            .navigationBarTitle(form.updating ? form.name : "New Vendor")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss)
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
    func dismiss() {
        self.isPresented = false
    }
    
    // Need to remove the vendor from the model and the created parentVendors becuase if only the model is changed, the form doesn't update
    func updateVendor() {
        if let vendorID = form.vendorID {
            vendorModel.update(vendorID: vendorID, name: form.name, descriptor: form.descriptor)
            
            // Also update the same vendor from parentVendors
            let index = parentVendors.firstIndex { $0.id == vendorID }
            let oldVendor = parentVendors[index!]
            oldVendor.name = form.name
            oldVendor.descriptor = form.descriptor
            dismiss()
        }
    }
    
    func saveVendor() {
        vendorModel.create(name: form.name, descriptor: form.descriptor)
        
        // Also add the vendor to parentVendor
        parentVendors.append(vendorModel.vendors.first(where: {
            $0.name == form.name
        })!)
        dismiss()
    }
    
    func deleteVendor(vendorID: Int) {
        vendorModel.delete(vendorID: vendorID)
        
        // Also delete the vendor from parentVendors
        let index = parentVendors.firstIndex { $0.id == vendorID }
        parentVendors.remove(at: index!)
        dismiss()
    }
}
