//
//  Backpack.swift
//  Backpack Drive Manager
//
//  Created by Eulices Martinez on 11/8/23.
//
import Foundation

class BackpackManager: ObservableObject {
    @Published var crosswalks: [Backpack] = []
    
    init() {
        // Add initial crosswalks for testing
        crosswalks.append(Backpack(name: "Titan hall", description: "800 N State College Blvd., Fullerton CA 92831"))
        crosswalks.append(Backpack(name: "Titan gym", description: "Gymnasium Campus Dr. Fullerton, CA 92831"))
        crosswalks.append(Backpack(name: "ECS building", description: "Campus Dr. Fullerton, CA 92831"))
        crosswalks.append(Backpack(name: "McCarthy Hall", description: "Campus Dr. Fullerton, CA 92831"))
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
