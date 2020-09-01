//
//  DrawShape.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-23.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct DrawShape: View {
    var centre: CGPoint
    var index: Int
    let data: [Pie]
    
    var body: some View {
        Path { path in
            path.move(to: self.centre)
            path.addArc(center: self.centre, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }
        .fill(data[index].color)
    }
    
    /// Calculates the angle that the next shape needs to start at
    func from() -> Double {
        
        if index == 0 {
            return 0
        }
        
        var temp: Double = 0
        var total: Double = 0
        var percentages: [Double] = []
        
        for i in 0..<data.count {
            total += Double(data[i].value)
        }
        for i in 0..<data.count {
            percentages.append(Double(data[i].value) / total)
        }
        for i in 0...index - 1 {
            temp += Double(CGFloat(percentages[i]) / 100) * 360
        }
        return temp
    }
    
    /// Converts the percentage to an angle
    func to() -> Double {
        var temp: Double = 0
        var total: Double = 0
        var percentages: [Double] = []
        
        /// Calculate the total just in case the total does not equal 100
        for i in 0..<data.count {
            total += Double(data[i].value)
        }
        for i in 0..<data.count {
            percentages.append(Double(data[i].value) / total)
        }

        for i in 0...index {
            temp += Double(CGFloat(percentages[i])) * 360
        }
        return temp
    }
    
}
