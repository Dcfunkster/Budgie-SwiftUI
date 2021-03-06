//
//  CategoryList.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CategoryList: View {
    
    @State private var deletingItem = false
    @State private var deleteIndexSet: IndexSet?
    
    @State private var showingAddView = false
    
    @State private var sortFunction: (Category, Category) throws -> Bool = { $0.name < $1.name } // TODO: save sort preference
    
    @State var categories: [Category]
    @EnvironmentObject var categoryModel: CategoryViewModel
    var accountSelection: Int

    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newCategoryButton

            ForEach(try! categories.sorted(by: sortFunction))
            { category in
                HStack {
                    Button(action: {
                        self.showingAddView.toggle()
                    }) {
                        Text(category.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddCategory(isPresented: self.$showingAddView,
                                form: CategoryForm(category),
                                parentCategories: $categories,
                                entries: category.entries!,
                                accountSelection: accountSelection)
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
        .onAppear {
            try! categories.sort(by: sortFunction)
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarHidden(false)
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                
                    Menu(content: {
                        Button(action: {
                            sortFunction = { $0.name < $1.name }
                            sortCategories()
                        }) {
                                Image(systemName: "arrow.up")
                                Text("Name (A-Z)")
                        }
                        Button(action: {
                            sortFunction = { $0.name > $1.name }
                            sortCategories()
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
                                            delete(categoryIndexSet: deleteIndexSet!)
                                          }))
    }
    
    var newCategoryButton: some View {
        Button(action: openNewCategory) {
            HStack {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Text("Add new category")
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddCategory(isPresented: self.$showingAddView,
                        form: CategoryForm(),
                        parentCategories: $categories,
                        accountSelection: accountSelection)
                .environmentObject(self.categoryModel)
        }
    }
}


//MARK: - Actions
extension CategoryList {
    func openNewCategory() {
        self.showingAddView = true
    }
    
    func sortCategories() {
        try! categories.sort(by: sortFunction)
    }
    
    func delete(categoryIndexSet: IndexSet) {
        
        // Given an index of the item to be deleted, find it in both lists and delete it
        if let first = categoryIndexSet.first {
            let categoryID = categories[first].id
            categoryModel.delete(categoryID: categoryID)
            categories.removeAll(where: { $0.id == categoryID }) // TODO: remove based on id, not index
        }
    }
}
