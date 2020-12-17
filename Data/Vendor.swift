//
//  Vendor.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift
import UIKit

class Vendor: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var descriptor: String? = nil
    @objc dynamic var colour: UIColor = UIColor.white
    
    override static func ignoredProperties() -> [String] {
        return ["colour"]
    }
    
}
