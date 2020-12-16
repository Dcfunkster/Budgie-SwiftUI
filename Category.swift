//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

class Category: Object {
    
    dynamic var name: String = ""
    dynamic var descriptor: String? = nil
    dynamic var moneySpentThisPeriod: Decimal = 0.0
    dynamic var colour: Color = Color.white
    
    let entries = RealmSwift.List<Entry>()

}
