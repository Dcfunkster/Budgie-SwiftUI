//
//  CategoryList.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

// List only updates when list going from zero to one
import SwiftUI
import RealmSwift

struct CategoryList: View {
    
    @State private var showingAddView: Bool = false
    @State var categoryListItems: Results<CategoryDB>? = realm.objects(CategoryDB.self)
    
    @EnvironmentObject var categoryModel: CategoryViewModel
    
    let categories: [Category]

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            if categories.isEmpty {
                Text("Press the add button to add your first category")
            }
            ForEach(categories) { category in
                CategoryRow(category: category)
            }
            newCategoryButton
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarHidden(false)
    }
    
    var newCategoryButton: some View {
        Button(action: openNewCategory) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("New Category")
                    .bold()
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddCategory(form: CategoryForm())
                .environmentObject(self.categoryModel)
        }
    }
}

//MARK: - Actions
extension CategoryList {
    func openNewCategory() {
        showingAddView.toggle()
    }
}
