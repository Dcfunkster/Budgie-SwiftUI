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
        
        NavigationView {
            VStack {
                ArcView(data: testArcData)
            }
        }
        .tabItem {
            VStack {
                Image(systemName: "dollarsign.circle")
                Text("Spending")
            }
        }
        .tag(0)
    }
}



struct SpendingView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            SpendingView()
        }
    }
}

var testArcData = [

    Pie(id: 0, value: 0, name: "Test1", color: Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))),
    Pie(id: 1, value: 1, name: "Test2", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    Pie(id: 2, value: 2, name: "Test3", color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))),
    Pie(id: 3, value: 0, name: "Test4", color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Pie(id: 4, value: 0, name: "Test5", color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))

]
