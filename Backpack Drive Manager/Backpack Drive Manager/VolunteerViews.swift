import SwiftUI

struct PeopleView: View {
    @EnvironmentObject var manager: VolunteerManager
    
    @State private var isAddVolunteerSheetPresented = false
    @State private var isVolunteerAdded = false
    var body: some View {
        
        VStack {
            HStack{
                Button("Add Volunteer") {
                    isAddVolunteerSheetPresented.toggle()
                }
                .modifier(ButtonDesign())
                .buttonStyle(.bordered)
                .sheet(isPresented: $isAddVolunteerSheetPresented) {
                    AddVolunteer(isVolunteerAdded: $isVolunteerAdded, isAddVolunteerSheetPresented: $isAddVolunteerSheetPresented) // Pass the binding
                }
                EditButton()
            }
            
            if isVolunteerAdded {
                            Text("Volunteer added successfully!") // Display a success message
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .animation(Animation.default.delay(2.0))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        isVolunteerAdded = false // Reset the flag after 2 seconds
                                    }
                                }
                        }
            List {
                /// ForEach requires each element in the collection it traverses to be Identifiable
                ForEach(manager.volunteers.sorted(by: {$0.hoursWorked > $1.hoursWorked})) {
                    volunteer in
                    VStack (alignment: .leading) {
                        Text(volunteer.name)
                            .font(.largeTitle)
                        Text("Age: "+String(volunteer.age))
                            .font(.caption)
                        Text("Hours Worked: "+String(volunteer.hoursWorked)+"hrs")
                        HStack{
                             Button("+"){
                                incFunc(for: volunteer, in: manager)
                            }
                            .buttonStyle(.bordered)
                            Button("-"){
                                decFunc(for: volunteer, in: manager)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }.onDelete {
                    offset in
                    manager.volunteers.remove(atOffsets: offset)
                } .onMove {
                    offset, index in
                    manager.volunteers.move(fromOffsets: offset,
                                            toOffset: index)
                }
            }
        }
    }
}

private func incFunc(for volunteer: Volunteer, in manager: VolunteerManager) {
    if let index = manager.volunteers.firstIndex(where: { $0.id == volunteer.id }) {
        manager.volunteers[index].hoursWorked += 1
    }
}
private func decFunc(for volunteer: Volunteer, in manager: VolunteerManager) {
    if let index = manager.volunteers.firstIndex(where: { $0.id == volunteer.id }) {
        manager.volunteers[index].hoursWorked -= 1
    }
}

struct AddVolunteer: View {
    @SceneStorage("volunteerName") var volunteerName: String = ""
    @SceneStorage("volunteerAge") var volunteerAge: Int = 0
    @SceneStorage("volunteerHours") var volunteerHours: Int = 0
    @EnvironmentObject var manager: VolunteerManager
    
    // Add a binding to track whether a Volunteer has been added
    @Binding var isVolunteerAdded: Bool
    @Binding var isAddVolunteerSheetPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Volunteer Submission")
                        .bold()
                        .font(.largeTitle)
                }
                .padding(.bottom, 30)
    
                HStack {
                    Text("Volunteer Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Volunteer name", text: $volunteerName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Volunteer Age")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("How old is this Volunteer?", text: Binding(
                        get: { String(volunteerAge) },
                        set: { volunteerAge = Int($0) ?? 0 }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Volunteer Hours Worked")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("How many hours did this Volunteer work?", text: Binding(
                        get: { String(volunteerHours) },
                        set: { volunteerHours = Int($0) ?? 0 }
                    ))
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack{
                    Button(action: {
                        manager.volunteers.append(Volunteer(name: volunteerName, age: volunteerAge, hoursWorked: volunteerHours))
                        volunteerName = ""
                        volunteerAge = 0
                        volunteerHours = 0
                        
                        // Set isVolunteerAdded to true to indicate a new Volunteer has been added
                        isVolunteerAdded = true
                        isAddVolunteerSheetPresented = false
                    }) {
                        Text("Submit")
                            .modifier(submitDesign())
                    }
                    Spacer()
                }
            }
            .padding()
            .onDisappear {
                // Automatically close the sheet when the view disappears
                isVolunteerAdded = false
            }
        }
    }
}
