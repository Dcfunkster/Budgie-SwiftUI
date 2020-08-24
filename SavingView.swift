//
//  SavingView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct SavingView: View {
    var body: some View {
        ArcView(data: secondTestArcData)
            .tabItem {
                VStack {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Saving")
                }
        }
        .tag(1)
    }
}

struct SavingView_Previews: PreviewProvider {
    static var previews: some View {
        SavingView()
    }
}

var secondTestArcData = [

    Pie(id: 0, value: 5, name: "Test1", color: Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))),
    Pie(id: 1, value: 1, name: "Test2", color: Color(#colorLiteral(red: 0.6620179415, green: 0, blue: 0.08410600573, alpha: 1))),
    Pie(id: 2, value: 2, name: "Test3", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    Pie(id: 3, value: 3, name: "Test4", color: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))),
    Pie(id: 4, value: 4, name: "Test5", color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Pie(id: 5, value: 21, name: "Test6", color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Pie(id: 6, value: 9, name: "Test7", color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))),

]
