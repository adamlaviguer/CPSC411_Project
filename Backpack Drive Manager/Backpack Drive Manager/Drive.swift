//
//  Drive.swift
//  Backpack Drive Manager
//
//  Created by Eulices Martinez on 11/10/23.
//

import Foundation

class DriveManager: ObservableObject {
    @Published var drives: [Drive] = []
    
    init() {
        // Add initial crosswalks for testing
        drives.append(Drive(name: "D hall", location: "800 N State College Blvd., Fullerton CA 92831"))
        drives.append(Drive(name: "D gym", location: "Gymnasium Campus Dr. Fullerton, CA 92831"))
    }
}

struct Drive: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var location: String
}
