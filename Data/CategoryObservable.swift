//
//  CategoryObservable.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-17.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

class CategoryObservable: ObservableObject {
    @Published var categories: Results<Category>? = realm.objects(Category.self)
}
