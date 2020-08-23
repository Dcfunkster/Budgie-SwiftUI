//
//  ContentView.swift
//  Test
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import Firebase

struct MainUI: View {
    @State var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            SpendingView()
            SavingView()
            AddView()
            EditView()
            SettingsView()
        }
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI(selection: 4)
    }
}
