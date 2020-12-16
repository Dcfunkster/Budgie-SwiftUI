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
    
    dynamic var amount: Decimal = 0.0
    dynamic var vendor: Vendor? = nil
    dynamic var frequency: Frequency? = nil

}
