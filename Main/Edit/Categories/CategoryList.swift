//
//  CategoryList.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//
// entries are not populating
import SwiftUI
import RealmSwift

struct CategoryList: View {

    @State private var deletingItem = false
    @State private var deleteIndexSet: IndexSet?
    
    @State private var showingAddView = false
    
    @State var categories: [Category]
    @EnvironmentObject var categoryModel: CategoryViewModel

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newCategoryButton
            
            ForEach(categories) { category in
                HStack {
                    Button(action: {
                        self.showingAddView.toggle()
                    }) {
                        Text(category.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddCategory(isPresented: self.$showingAddView, form: CategoryForm(category), parentCategories: $categories, entries: category.entries!)
                        .environmentObject(self.categoryModel)
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
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar { EditButton() }
    }
}

//MARK: - Views
extension CategoryList {
    func deleteAlert() -> Alert {
        let deletedCategoryName = categories[deleteIndexSet!.first!].name
        
        return Alert(
            title:           Text("Delete \(deletedCategoryName)?"),
            message:         Text("Deleting \(deletedCategoryName) will not remove all entries from that category."), // TODO: make it so that if entry does not have a category, add it to a "miscellaneous" or "other" category
            primaryButton:   .cancel(),
            secondaryButton: .destructive(Text("Delete"),
                                          action: {
                                            delete(deleteIndexSet!)
                                          }))
    }
    
    var newCategoryButton: some View {
        Button(action: openNewCategory) {
            HStack {
                Spacer()
                Image(systemName: "plus.circle.fill")
                Text("Add new category")
                    .bold()
                Spacer()
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddCategory(isPresented: self.$showingAddView, form: CategoryForm(), parentCategories: $categories)
                .environmentObject(self.categoryModel)
        }
    }
}


//MARK: - Actions
extension CategoryList {
    func openNewCategory() {
        self.showingAddView = true
    }
    
    func delete(_ categoryIndex: IndexSet) {
        
        // Given an index of the item to be deleted, find it in both lists and delete it
        if let first = categoryIndex.first {
            let categoryID = categories[first].id
            categoryModel.delete(categoryID: categoryID)
            categories.remove(at: first)
        }
    }
}
