//
//  EntryForm.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import UIKit
import RealmSwift

class VendorForm: ObservableObject {
    
    @Published var name = ""
    @Published var descriptor = ""
    @Published var colour = UIColor.white
    
    var vendorID: Int?
    
    var updating: Bool {
        vendorID != nil
    }
    
    init() { }
    
    init(_ vendor: Vendor) {
        name = vendor.name
        descriptor = vendor.descriptor!
        colour = vendor.colour
    }
}
