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
        Text("Second View")
            .font(.title)
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
