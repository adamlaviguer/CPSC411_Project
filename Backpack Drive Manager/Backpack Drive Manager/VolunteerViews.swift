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
                ForEach(manager.volunteers) {
                    volunteer in
                    VStack (alignment: .leading) {
                        Text(volunteer.name)
                            .font(.largeTitle)
                        Text(volunteer.age)
                            .font(.caption)
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

struct AddVolunteer: View {
    @SceneStorage("volunteerName") var volunteerName: String = ""
    @SceneStorage("volunteerAge") var volunteerAge: String = ""
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
                TextEditor(text: $volunteerAge)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.volunteers.append(Volunteer(name: volunteerName, age: volunteerAge))
                    volunteerName = ""
                    volunteerAge = ""
                    
                    // Set isVolunteerAdded to true to indicate a new Volunteer has been added
                    isVolunteerAdded = true
                    isAddVolunteerSheetPresented = false
                }) {
                    Text("Submit")
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
            .padding()
            .onDisappear {
                // Automatically close the sheet when the view disappears
                isVolunteerAdded = false
            }
        }
    }
}
