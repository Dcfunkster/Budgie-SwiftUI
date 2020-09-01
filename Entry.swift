//
//  Entry.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object {
    
    dynamic var category: Category = Category()
    dynamic var date: Date = Date()
    dynamic var deltaMoney: Decimal = 0.0
    dynamic var vendor: Vendor = Vendor()
    dynamic var descriptor: String? = nil
    
}
