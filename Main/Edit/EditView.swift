//
//  EditView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct EditView: View {
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    @EnvironmentObject var vendorModel: VendorViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Categories")) {
                
                NavigationLink(destination: CategoryList(accountSelection: 0)) {
                    Text("Spending")
                }
                .environmentObject(self.categoryModel)
                .environmentObject(self.entryModel)
                
                NavigationLink(destination: CategoryList(accountSelection: 1)) {
                    Text("Saving")
                }
                .environmentObject(self.categoryModel)
                .environmentObject(self.entryModel)
                
                NavigationLink(destination: CategoryList(accountSelection: 2)) {
                    Text("Income")
                }
                .environmentObject(self.categoryModel)
                .environmentObject(self.entryModel)
            }
            
            Section {
                NavigationLink(destination: VendorList()) {
                    Text("Vendors")
                }
                .environmentObject(self.vendorModel)
                .environmentObject(self.entryModel)
            }
        }
    }
}
