//
//  CategoryRow.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    @EnvironmentObject var categoryModel: CategoryViewModel
    @State private var showAddModal = false
    let category: Category
    
    var body: some View {
        
        HStack {
            Button(action: openUpdateCategory) {
                Text(category.name)
            }
        }
        .sheet(isPresented: $showAddModal) {
            AddCategory(form: CategoryForm(self.category))
                .environmentObject(self.categoryModel)
        }
    }
}


//MARK: - Actions
extension CategoryRow {
    func openUpdateCategory() {
        showAddModal.toggle()
    }
}