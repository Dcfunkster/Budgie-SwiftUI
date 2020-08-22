//
//  EditView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct EditView: View {
    var body: some View {
        Text("First View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "pencil.circle.fill")
                    Text("Edit")
                }
        }
        .tag(3)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
