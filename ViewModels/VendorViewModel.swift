//
//  VendorViewModel.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import RealmSwift

final class VendorViewModel: ObservableObject {
    private var vendorResults: Results<Vendor>
    
    init(realm: Realm) {
        vendorResults = realm.objects(Vendor.self)
    }
    
    var vendors: [Vendor] {
        vendorResults.map(Vendor.init)
    }
}

//MARK: - CRUD Actions
extension VendorViewModel {
    func create(name: String, descriptor: String) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let vendor = Vendor()
            vendor.name = name
            vendor.descriptor = descriptor
            
            try realm.write {
                realm.add(vendor)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
