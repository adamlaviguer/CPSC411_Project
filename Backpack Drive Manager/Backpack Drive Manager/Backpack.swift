//
//  Backpack.swift
//  Backpack Drive Manager
//
//  Created by Eulices Martinez on 11/8/23.
//
import Foundation

class BackpackManager: ObservableObject {
    @Published var backpacks: [Backpack] = []
    
    init() {
        // Add initial crosswalks for testing
        backpacks.append(Backpack(name: "Back To School Backpack", description: "20 available"))
        backpacks.append(Backpack(name: "Toy Backpack", description: "15 Available"))
        backpacks.append(Backpack(name: "Computer Backpack", description: "10 Available"))
        // TODO: Model 1 - Add another crosswalk object
    }
}

struct Backpack: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var description: String
}
