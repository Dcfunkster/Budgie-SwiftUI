//
//  ContentView.swift
//  Test
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

var realm = try! Realm()

struct MainUI: View {
    
    @State var selectedTab: Views = .spending
    @EnvironmentObject var categoryModel: CategoryViewModel
    @EnvironmentObject var vendorModel: VendorViewModel
    @EnvironmentObject var entryModel: EntryViewModel
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                SpendingView(entries: entryModel.entries)
                    .tabItem {
                        Image(systemName: "bag.circle.fill")
                        Text("Spending")
                    }.tag(Views.spending)
                SavingView()
                    .tabItem {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Saving")
                    }.tag(Views.saving)
                AddView(form: EntryForm(), categories: categoryModel.categories, vendors: vendorModel.vendors)
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
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI()
    }
}
