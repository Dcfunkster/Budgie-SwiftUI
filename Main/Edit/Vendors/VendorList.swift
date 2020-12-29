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

    @State private var showingAddView = false
    
    @State var vendors: [Vendor]
    @EnvironmentObject var vendorModel: VendorViewModel
    
    @State private var selectedVendor: Vendor?

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newVendorButton
            
            ForEach(vendors) { vendor in
                HStack {
                    Button(action: {
                        self.selectedVendor = vendor
                        self.showingAddView.toggle()
                    }) {
                        Text(vendor.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddVendor(isPresented: self.$showingAddView, form: VendorForm(vendor), parentVendors: $vendors)
                        .environmentObject(self.vendorModel)
                }
            }
            .onDelete(perform: delete)
        }
        .navigationBarTitle("Vendors", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar { EditButton() }
    }
    
    var newVendorButton: some View {
        Button(action: openNewVendor) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add new vendor")
                    .bold()
            }
                .multilineTextAlignment(.center)
        }
        .sheet(isPresented: $showingAddView) {
            AddVendor(isPresented: self.$showingAddView, form: VendorForm(), parentVendors: $vendors)
                .environmentObject(self.vendorModel)
        }
    }
}

//MARK: - Actions
extension VendorList {
    func openNewVendor() {
        self.showingAddView = true
    }
    
    func delete(vendorIndex: IndexSet) {
        if let first = vendorIndex.first {
            let vendorID = vendors[first].id
            vendorModel.delete(vendorID: vendorID)
            vendors.remove(at: first)
        }
    }
}
