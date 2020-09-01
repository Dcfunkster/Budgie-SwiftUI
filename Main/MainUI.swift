//
//  ContentView.swift
//  Test
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import Firebase
import RealmSwift

var realm = try! Realm()
var categories: Results<Category>?
var entries: Results<Entry>?

struct MainUI: View {
    @State var selection: Int = 3
 
    var body: some View {
        TabView(selection: $selection) {
            SpendingView()
            SavingView()
            AddView()
            EditView()
            SettingsView()
        }
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI(selection: 4)
    }
}
