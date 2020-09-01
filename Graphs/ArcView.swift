//
//  ArcView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-23.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct ArcView: View {
    
    let data: [Pie]
    
    var body: some View {
        VStack {
            GeometryReader { g in
                ZStack {
                    ForEach((0..<self.data.count).reversed(), id: \.self) { i in
                        DrawShape(centre: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i, data: self.data)
                            .onTapGesture {
                                print(self.data[i].name)
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
            //                ForEach(data) { i in
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
    }
    
    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        let temp = value / 100
        return temp * width
    }
    
}

struct Pie: Identifiable {
    var id: Int
    var value: CGFloat
    var name: String
    var color: Color
}
