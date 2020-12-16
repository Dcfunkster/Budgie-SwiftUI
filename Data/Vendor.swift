//
//  Vendor.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

class Vendor: Object {
    
    dynamic var name: String = ""
    dynamic var descriptor: String? = nil
    dynamic var colour: Color = Color.white
    
}
