//
//  SpendingView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct SpendingView: View {
    
    @State private var show: Bool = false
    
    var body: some View {
        
        VStack {

            GeometryReader { g in
                ZStack {
                    ForEach((0..<testArcData.count).reversed(), id: \.self) { i in
                        DrawShape(centre: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                            .onTapGesture {
                                print(testArcData[i].name)
                            }
                    }
                }
            }
            .frame(height: 360)
            .padding(.top, 20)
            .clipShape(Circle())
            .shadow(radius: 8)
  
            ///Optional bar graph beneath pie chart
//            VStack {
//                ForEach(testArcData) { i in
//                    HStack {
//                        Text(i.name)
//                            .frame(width: 100)
//                        GeometryReader { g in
//                            HStack {
//                                Spacer(minLength: 0)
//                                Capsule()
//                                    .fill(i.color)
//                                    .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.value), height: 10)
//                                Text(String(format: "\(i.value)", "%.0f"))
//                                    .fontWeight(.bold)
//                                    .padding(.leading, 10)
//                            }
//                        }
//                    }
//                    .padding(.top, 18)
//                }
//            }
//            .padding()
            
        }
        .edgesIgnoringSafeArea(.top)
        .tabItem {
            VStack {
                Image(systemName: "dollarsign.circle")
                Text("Spending")
            }
        }
        .tag(0)
    }
    
    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        let temp = value / 100
        return temp * width
    }
    
}

struct DrawShape: View {
    var centre: CGPoint
    var index: Int
    
    var body: some View {
        Path { path in
            path.move(to: self.centre)
            path.addArc(center: self.centre, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }
        .fill(testArcData[index].color)
    }
    
    /// Calculates the angle that the next shape needs to start at
    func from() -> Double {
        
        if index == 0 {
            return 0
        }
        
        var temp: Double = 0
        var total: Double = 0
        var percentages: [Double] = []
        
        for i in 0..<testArcData.count {
            total += Double(testArcData[i].value)
        }
        for i in 0..<testArcData.count {
            percentages.append(Double(testArcData[i].value) / total)
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
        for i in 0..<testArcData.count {
            total += Double(testArcData[i].value)
        }
        for i in 0..<testArcData.count {
            percentages.append(Double(testArcData[i].value) / total)
        }

        for i in 0...index {
            temp += Double(CGFloat(percentages[i])) * 360
        }
        return temp
    }
    
}

struct SpendingView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            SpendingView()
        }
    }
}

struct Pie: Identifiable {
    var id: Int
    var value: CGFloat
    var name: String
    var color: Color
}

var testArcData = [

    Pie(id: 0, value: 0, name: "Test1", color: Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))),
    Pie(id: 1, value: 1, name: "Test2", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    Pie(id: 2, value: 2, name: "Test3", color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))),
    Pie(id: 3, value: 0, name: "Test4", color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Pie(id: 4, value: 0, name: "Test5", color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))

]
