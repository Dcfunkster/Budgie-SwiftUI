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

var categories: Results<Category>? = realm.objects(Category.self)
var entries: Results<Entry>?

struct MainUI: View {
    
    @State var selectedTab: Views = .add
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SpendingView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Spending")
                }.tag(Views.spending)
            SavingView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Saving")
                }.tag(Views.saving)
            AddView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }.tag(Views.add)
            EditView()
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("Edit")
                }.tag(Views.edit)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }.tag(Views.settings)
        }
        .navigationTitle(Text(selectedTab.rawValue))
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden(true)
    }
}

enum Views: String {
    case spending = "Spending"
    case saving = "Saving"
    case add = "Add"
    case edit = "Edit"
    case settings = "Settings"
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI()
    }
}
