//
//  NumbersOnly.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-12-16.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            
            // Checks to see if first character is a decimal, if so, don't allow it
            if value == "." { value = "" }
            
            var filtered = value.filter { "0123456789.".contains($0) }
            
            // Ensures there is only one decimal allowed in the text
            if filtered.contains(".") {
                
                // Checks for multiple separated decimals
                let splitted = filtered.split(separator: ".")
                if splitted.count >= 2 {
                    let preDecimal = String(splitted[0])
                    let afterDecimal = String(splitted[1])
                    filtered = "\(preDecimal).\(afterDecimal)"
                }
                
                // Checks for strings of decimals
                let indexNum = filtered.distance(of: ".")!
                let index = filtered.firstIndex(of: ".")!
                if filtered.count > indexNum + 1 {
                    if filtered[indexNum + 1] == "." {
                        filtered.remove(at: index)
                    } else { // Only allow two decimal places
                        if filtered.count > indexNum + 3 {
                            filtered.removeLast()
                        }
                    }
                }
            
            }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self)}
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self)}
}
extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
