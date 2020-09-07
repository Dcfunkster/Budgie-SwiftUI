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
    var body: some View {
    TabView {
        SpendingView()
            .navigationBarTitle("Spending")
            .tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Spending")
            }
        SavingView()
            .navigationBarTitle("Saving")
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Saving")
            }
        AddView()
            .navigationBarTitle("Add")
            .tabItem {
                Image(systemName: "plus.circle.fill")
                Text("Add")
            }
        EditView()
            .navigationBarTitle("Edit")
            .tabItem {
                Image(systemName: "pencil.circle.fill")
                Text("Edit")
            }
        SettingsView()
            .navigationBarTitle("Settings")
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
    }
    .navigationBarBackButtonHidden(true)
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI()
    }
}
