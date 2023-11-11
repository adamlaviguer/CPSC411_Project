import SwiftUI

struct EditableBackpackList: View {
    @EnvironmentObject var manager: BackpackManager
    var body: some View {
        
        VStack {
            // TODO: Model 3 - Add the EditButton here
            EditButton()
            List {
                /// ForEach requires each element in the collection it traverses to be Identifiable
                ForEach(manager.crosswalks) {
                    crosswalk in
                    VStack (alignment: .leading) {
                        Text(crosswalk.name)
                            .font(.largeTitle)
                        Text(crosswalk.description)
                            .font(.caption)
                    }
                }.onDelete {
                    offset in
                    manager.crosswalks.remove(atOffsets: offset)
                } .onMove {
                    offset, index in
                    manager.crosswalks.move(fromOffsets: offset,
                                            toOffset: index)
                }
            }
        }
    }
}

struct DriveView: View {
    @EnvironmentObject var manager: DriveManager
    @State private var isAddDriveSheetPresented = false
    @State private var isDriveAdded = false
    var body: some View {
        
        VStack {
            // TODO: Model 3 - Add the EditButton here
            HStack{
                Button("Add Drive") {
                                    isAddDriveSheetPresented.toggle()
                                }
                                .modifier(ButtonDesign())
                                .buttonStyle(.bordered)
                                .sheet(isPresented: $isAddDriveSheetPresented) {
                                    AddDrive(isDriveAdded: $isDriveAdded, isAddDriveSheetPresented: $isAddDriveSheetPresented) // Pass the binding
                                }
                EditButton().buttonStyle(.bordered)
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
                ForEach(manager.drives) {
                    drive in
                    VStack (alignment: .leading) {
                        Text(drive.name)
                            .font(.largeTitle)
                        Text(drive.location)
                            .font(.caption)
                    }
                }.onDelete {
                    offset in
                    manager.drives.remove(atOffsets: offset)
                } .onMove {
                    offset, index in
                    manager.drives.move(fromOffsets: offset,
                                            toOffset: index)
                }
            }
        }
    }
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    Section(header: Text("Crosswalk")) {
//                        NavigationLink(destination: Text("Name of the crosswalk")) {
//                            Text("Crosswalk name")
//                        }
//                        NavigationLink(destination: Text("Address of the crosswalk")) {
//                            Text("Crosswalk address")
//                        }
//                    }
//                    Section(header: Text("Volunteer")) {
//                        NavigationLink(destination: Text("Name of the volunteer")) {
//                            Text("Volunteer")
//                        }
//                        DisclosureGroup(content: {
//                            NavigationLink(destination: Text("Minors can only volunteer for 1 hour and accompanied by an adult.")) {
//                                Text("Minors")
//                            }
//                            NavigationLink(destination: Text("Adults can volunteer for a maximum of 3 hours.")) {
//                                Text("Adults")
//                            }
//                            NavigationLink(destination: Text("Seniors can volunteer for a maximum of 2 hours.")) {
//                                Text("Seniors")
//                            }
//                        }) {
//                            Text("Maximum hours")
//                        }
//                    }
//                }
//                Spacer()
//            }
//        }
//    }
}

struct PeopleView: View {
    @SceneStorage("crosswalkName") var crosswalkName: String = ""
    @SceneStorage("crosswalkAddress") var crosswalkAddress: String = ""
    @EnvironmentObject var manager: VolunteerManager
    var body: some View {
        
        VStack {
            // TODO: Model 3 - Add the EditButton here
            EditButton()
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

struct AddDrive: View {
    @SceneStorage("crosswalkName") var crosswalkName: String = ""
    @SceneStorage("crosswalkAddress") var crosswalkAddress: String = ""
    @EnvironmentObject var manager: DriveManager
    
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
                    TextField("Drive name", text: $crosswalkName)
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
                TextEditor(text: $crosswalkAddress)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.drives.append(Drive(name: crosswalkName, location: crosswalkAddress))
                    crosswalkName = ""
                    crosswalkAddress = ""
                    
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
