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
        // Add initial backpack for testing
        backpacks.append(Backpack(name: "Back To School Backpack", description: "These are the Back to School Backpacks.", available: 3))
        backpacks.append(Backpack(name: "Toy Backpack", description: "These backpacks are made to store toys.", available: 5))
        backpacks.append(Backpack(name: "Computer Backpack", description: "These backpacks are made to carry computers.", available: 10))
    }
}

struct Backpack: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var description: String
    var available: Int
}
