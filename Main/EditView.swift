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
    
    @State private var categoryName: String = ""
    @State private var showCategoryAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(
                        destination: CategoryList()
                            .navigationBarTitle("Categories")
                            .navigationBarHidden(false)
                    ) {
                        Text("Categories")
                    }
                }
            }
            .navigationBarTitle("Edit Budget")
        }
        .tabItem {
            VStack {
                Image(systemName: "pencil.circle.fill")
                Text("Edit")
            }
        }
        .tag(3)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditView()
            .navigationBarTitle("Categories")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Plus button pressed")
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }
            )
        }
    }
}

struct CategoryList: View {
    var body: some View {

        NavigationView {
            List {
                /// Create a location for a category to be displayed for every category in entries
                ForEach(0..<(entries?.count ?? 1)) { i in
                    
                    NavigationLink(destination: EditCategory(selectedCategory: categories?[i])) {
                        
                        Text(categories?[i].name ?? "Press the + button to create a category")
                    
                    }
                    
                }

            }
            .navigationBarTitle("Categories")
            .navigationBarHidden(false)

            /// Plus button pressed
            .navigationBarItems(trailing:
                Button(action: {
                    /** I want to  1) Add a new row to the list
                               2) Let the user type directly into that new row with a TextField
                               3) Add the text the user selected as a new category**/
                    print("Plus button pressed")
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }
            )
        }
    }
}

struct EditCategory: View {
    var selectedCategory: Category?

    var body: some View {
        Form {
            Section {
                Text("New")
            }
        }
    }
}
