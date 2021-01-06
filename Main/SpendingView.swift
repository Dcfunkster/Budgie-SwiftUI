//
//  SpendingView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct SpendingView: View {
    
    @EnvironmentObject var entryModel: EntryViewModel
    @State var entries: [Entry]
    @State var sortFunction: (Entry, Entry) throws -> Bool = { $0.date > $1.date } // descending chronological
    
    @State private var show: Bool = false
    
    var body: some View {

        ScrollView { // scrolling problem is with scrollview for sure

            ArcView(data: testArcData)
            
            Text("Entries")
                .font(.title).padding()
            ForEach(try! entries.sorted(by: sortFunction)) { e in
                HStack {
                    Text("\(e.vendor?.name ?? "Miscellaneous")")
                        .bold().padding(.leading)
                        .onAppear {
                            print("\(e.vendor?.name ?? "Miscellaneous")")
                        }
                    Spacer()
                    if e.deltaMoney < 0 {
                        Text(NumberFormatter.localizedString(from: NSNumber(value: e.deltaMoney), number: .currency))
                            .foregroundColor(.red).padding(.trailing)
                    } else {
                        Text(NumberFormatter.localizedString(from: NSNumber(value: e.deltaMoney), number: .currency))
                            .padding(.trailing)
                    }
                }
            }
            
        }
        .onAppear {
            entries = entryModel.entries
            try! entries.sort(by: sortFunction)
        }
    }
}

//struct SpendingView_Previews: PreviewProvider {
//
//    var entries: [Entry] = testEntryData
//
//    static var previews: some View {
//        TabView {
//            NavigationView {
//                TabView {
//                    SpendingView(entries: entryModel.entries)
//                }
//                .navigationTitle("Spending")
//            }
//        }
//    }
//}

var testArcData = [

    Pie(id: 0, value: 0, name: "Test1", color: Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1))),
    Pie(id: 1, value: 1, name: "Test2", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    Pie(id: 2, value: 2, name: "Test3", color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))),
    Pie(id: 3, value: 0, name: "Test4", color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Pie(id: 4, value: 0, name: "Test5", color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))

]
