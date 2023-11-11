//
//  ContentView.swift
//  Backpack Drive Manager
//
//  Created by Adam Laviguer on 10/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = BackpackManager()
    @StateObject var volunteerManager = VolunteerManager()
    @StateObject var driveManager = DriveManager()
    var body: some View {
        TabView {
            EditableBackpackList().tabItem {
                Image(systemName: "backpack")
                Text("Backpacks")
            }
            DriveView().tabItem {
                Image(systemName:"info")
                Text("Drives")
            }
            PeopleView().tabItem{
                Image(systemName: "person")
                Text("Volunteers")
            }
        }
        .environmentObject(manager).environmentObject(volunteerManager).environmentObject(driveManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
