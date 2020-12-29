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
    
    @State private var showingAddView = false
    
    @State var categories: [Category]
    @EnvironmentObject var categoryModel: CategoryViewModel
    
    @State private var selectedCategory: Category?

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newCategoryButton
            
            ForEach(categories) { category in
               // CategoryRow(category: category)
                HStack {
                    Button(action: {
                        self.selectedCategory = category
                        self.showingAddView.toggle()
                    }) {
                        Text(category.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddCategory(isPresented: self.$showingAddView, form: CategoryForm(category), categories: categories)
                        .environmentObject(self.categoryModel)
                }
            }
            .onDelete(perform: delete)
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar { EditButton() }
    }
    
    var newCategoryButton: some View {
        Button(action: openNewCategory) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add new category")
                    .bold()
            }
                .multilineTextAlignment(.center)
        }
        .sheet(isPresented: $showingAddView) {
            AddCategory(isPresented: self.$showingAddView, form: CategoryForm(), categories: categories)
                .environmentObject(self.categoryModel)
        }
    }
}

//MARK: - Actions
extension CategoryList {
    func openNewCategory() {
        self.showingAddView = true
    }
    
    func delete(categoryIndex: IndexSet) {
        if let first = categoryIndex.first {
            let categoryID = categories[first].id
            categoryModel.delete(categoryID: categoryID)
            categories.remove(at: first)
        }
    }
}
