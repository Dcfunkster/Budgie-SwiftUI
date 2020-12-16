//
//  AddView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import RealmSwift

struct AddView: View {
    @State private var category: Int = 0
    @State private var date = Date()
    @ObservedObject var amount = NumbersOnly()
    @State private var vendor: String = ""
    @State private var description: String = ""
    
    let realm = try! Realm()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(0..<(entries?.count ?? 1)) {
                        Text(entries?[$0].testCategory?.name ?? "Go to the Edit tab to add a new category!")
                    }
                }
                
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
                
                HStack {
                    Text("Amount ($)")
                    Spacer()
                    TextField("E.g. 5.67", text: $amount.value)
                        .keyboardType(.decimalPad)
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
                Button(action: {
//                    let newEntry = Entry()
//                    //newEntry.category = category -need to make a universally accessible list of categories stored in db
//                    newEntry.date = date
//                    newEntry.deltaMoney = Decimal((amount.value as NSString).doubleValue)
//                    //newEntry.vendor = vendor -also need a list of vendors stored in db
//                    newEntry.descriptor = description
                }, label: {Text("Add Entry")})
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            AddView()
        }
    }
}
