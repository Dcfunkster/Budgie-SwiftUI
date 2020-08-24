//
//  AddView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var selection: Int = 0
    @State private var date = Date()
    @State private var amount: String = ""
    @State private var vendor: String = ""
    @State private var description: String = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $selection, label: Text("Category")) {
                    ForEach(0..<testData.count) {
                        Text(testData[$0].name)
                    }
                }
                
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
                
                HStack {
                    Text("Amount ($)")
                    Spacer()
                    TextField("E.g. 5.67", text: $amount)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Vendor")
                    TextField("E.g. McDonald's", text: $vendor)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Description")
                    TextField("E.g. Lunch with friends", text: $description)
                        .multilineTextAlignment(.trailing)
                }
            }
            Section {
                NavigationLink(destination: SpendingView(), label: {
                    Text("Add Entry")
                })
            }
        }
            .tabItem {
                VStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
        }
        .tag(2)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            AddView()
        }
    }
}
