//
//  CategoryForm.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import UIKit

class CategoryForm: ObservableObject {
    @Published var name = ""
    @Published var descriptor = ""
    @Published var colour = UIColor.white
    //@Published var color
    var categoryID: Int?
    
    var updating: Bool {
        categoryID != nil
    }
    
    init() { }
    
    init(_ category: Category) {
        name = category.name
        descriptor = category.descriptor!
        categoryID = category.id
        colour = category.colour
    }
}
