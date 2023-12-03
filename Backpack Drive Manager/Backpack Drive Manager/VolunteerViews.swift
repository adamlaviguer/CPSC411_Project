import SwiftUI

struct PeopleView: View {
    @EnvironmentObject var manager: VolunteerManager
    
    @State private var isAddDriveSheetPresented = false
    @State private var isDriveAdded = false
    var body: some View {
        
        VStack {
            HStack{
                Button("Add Volunteer") {
                    isAddDriveSheetPresented.toggle()
                }
                .modifier(ButtonDesign())
                .buttonStyle(.bordered)
                .sheet(isPresented: $isAddDriveSheetPresented) {
                    AddDrive(isDriveAdded: $isDriveAdded, isAddDriveSheetPresented: $isAddDriveSheetPresented) // Pass the binding
                }
                EditButton()
            }
            
            if isDriveAdded {
                            Text("Drive added successfully!") // Display a success message
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .animation(Animation.default.delay(2.0))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        isDriveAdded = false // Reset the flag after 2 seconds
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
    
    // Add a binding to track whether a new drive has been added
    @Binding var isDriveAdded: Bool
    @Binding var isAddDriveSheetPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Drive Submission")
                        .bold()
                        .font(.largeTitle)
                }
                .padding(.bottom, 30)
    
                HStack {
                    Text("Drive Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Drive name", text: $volunteerName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Drive address")
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
                    
                    // Set isDriveAdded to true to indicate a new drive has been added
                    isDriveAdded = true
                    isAddDriveSheetPresented = false
                }) {
                    Text("Submit")
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
            .padding()
            .onDisappear {
                // Automatically close the sheet when the view disappears
                isDriveAdded = false
            }
        }
    }
}
