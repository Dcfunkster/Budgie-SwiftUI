//
//  EditView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

var realm = try! Realm()

struct EditView: View {
    
    @State private var categoryName: String = ""
    @State private var showCategoryAlert = false
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: CategoryList()
                        .navigationBarTitle("Categories", displayMode: .inline)
                        .navigationBarHidden(false)
//                        .onAppear(perform: {
//                            load()
//                        })
                ) {
                    Text("Categories")
                }
            }
        }
    }
}

struct CategoryList: View {
    
    @State private var showingAddView: Bool = false
    @State private var editBtnPressed: Bool = false
    @State private var cancelBtnPressed: Bool = true
    @State var categoryListItems: Results<Category>? = realm.objects(Category.self)
    
    @EnvironmentObject var categories: CategoryObservable

    var body: some View {
        
        /// Create a location for a category to be displayed for every category in entries
        if let safeCategories = categoryListItems { // Categories found in db
            List {
                ForEach(0..<(safeCategories.count)) { i in
                    NavigationLink(destination: EditCategory(selectedCategory: safeCategories[i])) {
                        Text(safeCategories[i].name)
                    }
                }
            }
            .navigationBarTitle("Categories", displayMode: .inline)
            // Edit button pressed
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    if cancelBtnPressed {
//                        Button("Edit", action: {
//                            editBtnPressed = true
//                            cancelBtnPressed = false
//                        })
//                    } else if editBtnPressed {
//                        Button("Cancel", action: {
//                            cancelBtnPressed = true
//                            editBtnPressed = false
//                        })
//                    }
                    Button(action: {
                        self.showingAddView.toggle()
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }.sheet(isPresented: $showingAddView) {
                        AddCategory(showModal: self.$showingAddView)
                    }
                }
            })
        } else { // No categories
            ScrollView {
                Text("Press the Edit button to start adding!").padding()
            }
            .navigationBarTitle("Categories", displayMode: .inline)
            // Edit button pressed
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    if cancelBtnPressed {
//                        Button("Edit", action: {
//                            editBtnPressed = true
//                            cancelBtnPressed = false
//                        })
//                    } else if editBtnPressed {
//                        Button("Cancel", action: {
//                            cancelBtnPressed = true
//                            editBtnPressed = false
//                        })
//                    }
                    
                    Button(action: {
                        self.showingAddView.toggle()
                    }) {
                        Image(systemName: "plus").imageScale(.large)
                    }.sheet(isPresented: $showingAddView) {
                        AddCategory(showModal: self.$showingAddView)
                    }
                    
                }
            })
        }
        /** I want to  1) Add a new row to the list
                   2) Let the user type directly into that new row with a TextField
                   3) Add the text the user selected as a new category**/
    }
}

func save(_ category: Category) {
    do {
        try realm.write {
            realm.add(category)
        }
    } catch {
        print("Error saving category \(error)")
    }
}
func load() {
    categoryListItems = realm.objects(Category.self)
}

struct AddCategory: View {
    
    @State private var name: String = ""
    @State private var descriptor: String = ""
    @State private var colour = Color.red
    @Binding var showModal: Bool
    
    @EnvironmentObject var categories: CategoryObservable
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showModal.toggle()
            }) {
                Image(systemName: "xmark.circle.fill")
            }
            .padding()
            .foregroundColor(.gray)
            .imageScale(.large)
        }
        Form {
            Text("Add new category")
            Section {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Groceries", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Description")
                    Spacer()
                    TextField("Optional", text: $descriptor)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Colour")
                    Spacer()
                    ColorPicker("", selection: $colour, supportsOpacity: false) // Want this to eventually automatically choose a colour that the user has not previously selected.
                        .multilineTextAlignment(.trailing)
                }
                Button(action: {
                    
                    self.showModal = false
                    let newCategory = Category()
                    newCategory.name = name
                    newCategory.descriptor = descriptor
                    newCategory.colour = UIColor(colour)
                    save(newCategory)
                }) {
                    Text("Add Category")
                }
            }
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

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryList()
        }
    }
}
