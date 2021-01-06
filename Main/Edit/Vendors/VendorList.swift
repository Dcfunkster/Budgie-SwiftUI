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
    
    @State var vendors: [Vendor]
    @EnvironmentObject var vendorModel: VendorViewModel

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newVendorButton
            
            ForEach(try! vendors.sorted(by: sortFunction)) { vendor in
                HStack {
                    Button(action: {
                        self.showingAddView.toggle()
                    }) {
                        Text(vendor.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddVendor(isPresented: self.$showingAddView, form: VendorForm(vendor), parentVendors: $vendors, entries: vendor.entries!)
                        .environmentObject(self.vendorModel)
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
        .onAppear {
            try! vendors.sort(by: sortFunction)
        }
        .navigationBarTitle("Vendors", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            
                Menu(content: {
                    Button(action: {
                        sortFunction = { $0.name < $1.name }
                        sortVendors()
                    }) {
                            Image(systemName: "arrow.up")
                            Text("Name (A-Z)")
                    }
                    Button(action: {
                        sortFunction = { $0.name > $1.name }
                        sortVendors()
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
            AddVendor(isPresented: self.$showingAddView, form: VendorForm(), parentVendors: $vendors)
                .environmentObject(self.vendorModel)
        }
    }
}

//MARK: - Views
extension VendorList {
    func deleteAlert() -> Alert {
        let deletedVendorName = vendors[deleteIndexSet!.first!].name
        
        return Alert(
            title:           Text("Delete \(deletedVendorName)?"),
            message:         Text("Deleting \(deletedVendorName) will not remove all entries from that vendor."), // TODO: make it so that if entry does not have a vendor, add it to a "miscellaneous" or "other" category
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
    
    func sortVendors() {
        try! vendors.sort(by: sortFunction)
    }
    
    func delete(_ vendorIndex: IndexSet) {
        
        // Given an index of the item to be deleted, find it in both lists and delete it
        if let first = vendorIndex.first {
            let vendorID = vendors[first].id
            
            vendorModel.delete(vendorID: vendorID)
            vendors.removeAll(where: { $0.id == vendorID })
        }
    }
}
