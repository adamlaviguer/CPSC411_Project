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
        volunteers.append(Volunteer(name: "V hall", age: "800 N State College Blvd., Fullerton CA 92831"))
        volunteers.append(Volunteer(name: "V gym", age: "Gymnasium Campus Dr. Fullerton, CA 92831"))
        volunteers.append(Volunteer(name: "ECS building", age: "Campus Dr. Fullerton, CA 92831"))
        volunteers.append(Volunteer(name: "McCarthy Hall", age: "Campus Dr. Fullerton, CA 92831"))
        // TODO: Model 1 - Add another crosswalk object
    }
}

struct Volunteer: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var age: String
}
