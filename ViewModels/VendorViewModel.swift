//
//  VendorViewModel.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-29.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation
import RealmSwift

//final class VendorViewModel: ObservableObject {
//    var vendors: Results<Vendor>
//
//    init(realm: Realm) {
//        vendors = realm.objects(Vendor.self)
//    }
//}
//
////MARK: - CRUD Actions
//extension VendorViewModel {
//    func create(name: String, descriptor: String) {
//        objectWillChange.send()
//
//        do {
//            let realm = try Realm()
//
//            let vendorDB = Vendor()
//            vendorDB.id = UUID().hashValue
//            vendorDB.name = name
//            vendorDB.descriptor = descriptor
//
//            try realm.write {
//                realm.add(vendorDB)
//            }
//        } catch {
//            print("Error creating new category, \(error.localizedDescription)")
//        }
//    }
//
//    func update(vendorID: Int, name: String, descriptor: String) {
//        objectWillChange.send()
//
//        do {
//            let realm = try! Realm()
//            try realm.write {
//                realm.create(Vendor.self,
//                             value: [
//                                "id": vendorID,
//                                "name": name,
//                                "descriptor": descriptor],
//                             update: .modified)
//            }
//        } catch {
//            print("Error updating vendor, \(error.localizedDescription)")
//        }
//    }
//
//    func update(vendorID: Int, name: String, descriptor: String, entries: List<EntryDB>, newEntry: EntryDB) {
//        objectWillChange.send()
//
//        let appendedEntries = RealmSwift.List<EntryDB>()
//        entries.forEach {
//            appendedEntries.append($0)
//        }
//        appendedEntries.append(newEntry)
//
//
//        do {
//            let realm = try! Realm()
//            try realm.write {
//                realm.create(Vendor.self,
//                             value: [
//                                "id": vendorID,
//                                "name": name,
//                                "descriptor": descriptor,
//                                "entries": appendedEntries],
//                             update: .modified)
//            }
//        } catch {
//            print("Error adding entry to vendor, \(error.localizedDescription)")
//        }
//
//    }
//
//    func delete(vendorID: Int) {
//        objectWillChange.send()
//
//        guard let vendorDB = vendors.first(where: { $0.id == vendorID })
//        else { return }
//
//
//        do {
//            let realm = try Realm()
//
//            try realm.write {
//                realm.delete(vendorDB)
//            }
//        } catch {
//            print("Error deleting category, \(error.localizedDescription)")
//        }
//    }
//}
