//
//  Bill.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-18.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

/// A recurring payment to be taken out of account automatically

import Foundation
import RealmSwift

class Bill: Object {
    
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var vendor: Vendor? = nil
    //@objc dynamic var frequency: Frequency? = nil

}
