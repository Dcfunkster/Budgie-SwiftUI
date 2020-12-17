//
//  Category.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift
import UIKit

class Category: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var descriptor: String?
    @objc dynamic var moneySpentThisPeriod: Double = 0.0
    @objc dynamic var colour: UIColor = UIColor.white
    
    let entries = RealmSwift.List<Entry>()

    override static func ignoredProperties() -> [String] {
        return ["colour"]
    }
}
