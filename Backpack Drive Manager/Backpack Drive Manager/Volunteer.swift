//
//  volunteer.swift
//  Backpack Drive Manager
//
//  Created by Eulices Martinez on 11/10/23.
//

import Foundation

class VolunteerManager: ObservableObject {
    @Published var volunteers: [Volunteer] = []
    
    init() {
        // Add initial crosswalks for testing
        volunteers.append(Volunteer(name: "Eulices", age: "37"))
        volunteers.append(Volunteer(name: "Adam", age: "19"))
        volunteers.append(Volunteer(name: "Kingston", age: "20"))
    }
}

struct Volunteer: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var age: String
}
