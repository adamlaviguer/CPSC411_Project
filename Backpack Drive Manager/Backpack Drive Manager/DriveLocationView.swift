import SwiftUI

struct DriveView: View {
    @EnvironmentObject var manager: DriveManager
    @State private var isAddDriveSheetPresented = false
    @State private var isDriveAdded = false
    var body: some View {
        
        VStack {
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
}


struct AddDrive: View {
    @SceneStorage("driveName") var driveName: String = ""
    @SceneStorage("driveAddress") var driveAddress: String = ""
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
                    TextField("Drive name", text: $driveName)
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
                TextEditor(text: $driveAddress)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.drives.append(Drive(name: driveName, location: driveAddress))
                    driveName = ""
                    driveAddress = ""
                    
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
