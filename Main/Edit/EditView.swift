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
    
    var body: some View {
        Form {
            Section(header: Text("Categories")) {
                
                NavigationLink(destination: CategoryList(accountSelection: 0)) {
                    Text("Spending")
                }
                
                NavigationLink(destination: CategoryList(accountSelection: 1)) {
                    Text("Saving")
                }
                
                NavigationLink(destination: CategoryList(accountSelection: 2)) {
                    Text("Income")
                }
            }
            
            Section {
                NavigationLink(destination: VendorList()) {
                    Text("Vendors")
                }
            }
        }
    }
}
