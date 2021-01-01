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
    
    @State private var spendingCategories = [Category]()
    @State private var savingCategories = [Category]()
    
    var body: some View {
        Form {
            Section(header: Text("Categories")) {
                
                NavigationLink(destination: CategoryList(categories: spendingCategories, accountSelection: 0)) {
                    Text("Spending")
                }
                NavigationLink(destination: CategoryList(categories: savingCategories, accountSelection: 1)) {
                    Text("Saving")
                }
            }
            
            Section {
                NavigationLink(destination: VendorList(vendors: vendorModel.vendors)) {
                    Text("Vendors")
                }
            }
        }
        .onAppear(perform: categorySort)
    }
}

extension EditView {
    func categorySort() {
        // Reset these two arrays to blank in case they are populated
        spendingCategories = [Category]()
        savingCategories = [Category]()
        
        categoryModel.categories.forEach {
            if $0.accountSelection == 0 { //spending
                spendingCategories.append($0)
            } else {
                savingCategories.append($0)
            }
        }
    }
}
