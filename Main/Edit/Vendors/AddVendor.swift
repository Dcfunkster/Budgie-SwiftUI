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
    
    var selectedVendor: Vendor
    
    // FORM
    @State private var updating = false
    @State private var vendorID: Int?
    @State private var name = ""
    @State private var descriptor = ""
    
    var entries = realm.objects(Entry.self)
    var vendors = realm.objects(Vendor.self)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Superstore", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Description")
                        Spacer()
                        TextField("Optional", text: $descriptor)
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
                    if updating {
                        Button("Delete", action: {
                            deleteVendor(vendorID: vendorID!)
                        })
                        .foregroundColor(.red)
                    }
                }
                Section {
                    if updating {
                        Text("Recent Entries")
                        ForEach(entries.filter({ $0.linkingVendor.first == selectedVendor })) { e in
                            Text("\(e.linkingVendor.first!.name)")
                        }
                    }
                }
            }
            .navigationBarTitle(updating ? name : "New Vendor")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { self.isPresented.toggle() })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(updating ? "Update" : "Save", action: updating ? updateVendor : saveVendor)
                }
            })
        }
    }
}

//MARK: - Actions
extension AddVendor {
    // Need to remove the vendor from the model and the created parentVendors becuase if only the model is changed, the form doesn't update
    func updateVendor() {
        if let safeVendorID = vendorID {
                
            do {
                let realm = try! Realm()
                try realm.write {
                    realm.create(Vendor.self,
                                 value: [
                                    "id": safeVendorID,
                                    "name": name,
                                    "descriptor": descriptor],
                                 update: .modified)
                }
            } catch {
                print("Error updating vendor, \(error.localizedDescription)")
            }
            
            
            self.isPresented.toggle()
        }
    }
    
    func saveVendor() {
        
        do {
            let realm = try Realm()

            let vendorDB = Vendor()
            vendorDB.id = UUID().hashValue
            vendorDB.name = name
            vendorDB.descriptor = descriptor

            try realm.write {
                realm.add(vendorDB)
            }
        } catch {
            print("Error creating new category, \(error.localizedDescription)")
        }
        
        
        self.isPresented.toggle()
    }
    
    func deleteVendor(vendorID: Int) {
        
        guard let vendorDB = vendors.first(where: { $0.id == vendorID })
        else { return }


        do {
            let realm = try Realm()

            try realm.write {
                realm.delete(vendorDB)
            }
        } catch {
            print("Error deleting category, \(error.localizedDescription)")
        }
        
        self.isPresented.toggle()
    }
}
