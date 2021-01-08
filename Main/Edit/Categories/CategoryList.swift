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
    
//    @State private var selectedCategory = Category()
    var accountSelection: Int
    
    @State private var categories = realm.objects(Category.self)
    
    var body: some View {
        
        // Create a location for a category to be displayed for every category in entries
        List {
            newCategoryButton

            ForEach(try! categories.filter({ $0.accountSelection == accountSelection }).sorted(by: sortFunction))
            { category in
                HStack {
                    Button(action: {
                        self.showingAddView.toggle()
//                        selectedCategory = category
                    }) {
                        Text(category.name)
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddCategory(isPresented: self.$showingAddView,
//                                selectedCategory: selectedCategory,
                                accountSelection: accountSelection)
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
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                
                    Menu(content: {
                        Button(action: {
                            sortFunction = { $0.name < $1.name }
                        }) {
                                Image(systemName: "arrow.up")
                                Text("Name (A-Z)")
                        }
                        Button(action: {
                            sortFunction = { $0.name > $1.name }
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
        
        let unSortedActiveCategories = categories.filter({$0.accountSelection == accountSelection})
        let sortedCategories: [Category]?
        var deletedCategoryName: String?
        
        do {
            sortedCategories = try unSortedActiveCategories.sorted(by: sortFunction)
            deletedCategoryName = sortedCategories?[deleteIndexSet!.first!].name
        } catch {
            print(error.localizedDescription)
        }
        
        return Alert(
            title:           Text("Delete \(deletedCategoryName ?? "nil")?"),
            message:         Text("Deleting \(deletedCategoryName ?? "nil") will not remove all entries from that category."), // TODO: make it so that if entry does not have a category, add it to a "miscellaneous" or "other" category
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
//                        selectedCategory: selectedCategory,
                        accountSelection: accountSelection)
        }
    }
}


//MARK: - Actions
extension CategoryList {
    func openNewCategory() {
        self.showingAddView = true
    }
    
    func delete(categoryIndexSet: IndexSet) {
        
        // Given an index of the item to be deleted, find it in both lists and delete it
        DispatchQueue.main.async {
            autoreleasepool {
                if let first = categoryIndexSet.first {
                    
                    do {
                        let categoryID = try categories.filter({ $0.accountSelection == accountSelection }).sorted(by: sortFunction)[first].id
                        
                        guard let categoryDB = categories.first(
                            where: { $0.id == categoryID })
                        else { return }
                
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.delete(categoryDB)
                                realm.refresh()
                            }
                        } catch {
                            print("Error deleting category, \(error.localizedDescription)")
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    // TODO: remove based on id, not index
                }
            }
        
        }
    }
}
