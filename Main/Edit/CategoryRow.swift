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
    @State var showAddModal = false
    let category: Category

    var body: some View {

        HStack {
            Button(action: openUpdateCategory) {
                Text(category.name)
            }
        }
        .sheet(isPresented: $showAddModal) {
            AddCategory(isPresented: self.$showAddModal, form: CategoryForm(self.category), categories: self.categoryModel.categories)
                .environmentObject(self.categoryModel)
        }
    }
}


//MARK: - Actions
extension CategoryRow {
    func openUpdateCategory() {
        self.showAddModal = true
    }
}
