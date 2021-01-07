//
//  CategoryList.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct VendorList: View {

    @State private var deletingItem = false
    @State private var deleteIndexSet: IndexSet?
    
    @State private var showingAddView = false
    
    @State private var sortFunction: (Vendor, Vendor) throws -> Bool = { $0.name < $1.name } // TODO: save sort preference
    
    @EnvironmentObject var vendorModel: VendorViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    @State private var selectedVendor = Vendor()

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newVendorButton
            
            ForEach(try! vendorModel.vendors.sorted(by: sortFunction)) { vendor in
                HStack {
                    Button(action: {
                        self.showingAddView.toggle()
                        selectedVendor = vendor
                    }) {
                        Text(vendor.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddVendor(isPresented: self.$showingAddView, form: VendorForm(vendor), selectedVendor: selectedVendor)
                        .environmentObject(self.vendorModel)
                        .environmentObject(self.entryModel)
                }
                .alert(isPresented: $deletingItem) {
                    deleteAlert()
                }
            }
            .onDelete { indexSet in
                self.deletingItem.toggle()
                self.deleteIndexSet = indexSet
            }
        }
        .navigationBarTitle("Vendors", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            
                Menu(content: {
                    Button(action: {
                        sortFunction = { $0.name < $1.name }
                    }) {
                            Image(systemName: "arrow.up")
                            Text("Name (A-Z)")
                    }
                    Button(action: {
                        sortFunction = { $0.name > $1.name }
                    }) {
                            Image(systemName: "arrow.down")
                            Text("Name (Z-A)")
                    }
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                        .padding()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
        }
    }
    
    var newVendorButton: some View {
        Button(action: openNewVendor) {
            HStack {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Text("Add new vendor")
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddVendor(isPresented: self.$showingAddView, form: VendorForm(), selectedVendor: selectedVendor)
                .environmentObject(self.vendorModel)
        }
    }
}

//MARK: - Views
extension VendorList {
    func deleteAlert() -> Alert {
        
        var sortedVendors: [Vendor]?
        var deletedVendorName: String?
        
        do {
            sortedVendors = try vendorModel.vendors.sorted(by: sortFunction)
            deletedVendorName = sortedVendors?[deleteIndexSet!.first!].name
        } catch {
            print(error.localizedDescription)
        }
        
        return Alert(
            title:           Text("Delete \(deletedVendorName ?? "nil")?"),
            message:         Text("Deleting \(deletedVendorName ?? "nil") will not remove all entries from that vendor."), // TODO: make it so that if entry does not have a vendor, add it to a "miscellaneous" or "other" category
            primaryButton:   .cancel(),
            secondaryButton: .destructive(Text("Delete"),
                                          action: {
                                            delete(deleteIndexSet!)
                                          }))
    }
}

//MARK: - Actions
extension VendorList {
    func openNewVendor() {
        self.showingAddView = true
    }
    
    func delete(_ vendorIndexSet: IndexSet) {
        
        // Given an index of the item to be deleted, find it in both lists and delete it
        if let first = vendorIndexSet.first {
            
            do {
                let vendorID = try vendorModel.vendors.sorted(by: sortFunction)[first].id
                vendorModel.delete(vendorID: vendorID)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
