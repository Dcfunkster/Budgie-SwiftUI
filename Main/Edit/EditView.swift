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
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: CategoryList(categories: categoryModel.categories)) {
                    Text("Categories")
                }
                NavigationLink(destination: VendorList(vendors: vendorModel.vendors)) {
                    Text("Vendors")
                }
            }
        }
    }
}

struct EditCategory: View {
    var selectedCategory: CategoryDB?

    var body: some View {
        Form {
            Section {
                Text(selectedCategory!.name)
            }
        }
    }
}
