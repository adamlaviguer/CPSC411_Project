//
//  ContentView.swift
//  Backpack Drive Manager
//
//  Created by Adam Laviguer on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = BackpackManager()
    var body: some View {
        TabView {
            EditableBackpackList().tabItem {
                Image(systemName: "backpack")
                Text("Backpack")
            }
            BackpackInfo().tabItem {
                Image(systemName:"info")
                Text("Backpack Info")
            }
            AddBackpack().tabItem{
                Image(systemName: "plus")
                Text("Add Backpack")
            }
            AddBackpack().tabItem{
                Image(systemName: "plus")
                Text("Add Item")
            }
            AddBackpack().tabItem{
                Image(systemName: "plus")
                Text("Add Volunteer")
            }
        }
        .environmentObject(manager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
