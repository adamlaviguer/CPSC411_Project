import SwiftUI

struct EditableBackpackList: View {
    @EnvironmentObject var manager: BackpackManager
    @State private var isAddBackupSheetPresented = false
    @State private var isBackpackAdded = false
    
    var body: some View {
        
        VStack {
            HStack{
                Button("Add Backpack") {
                                    isAddBackupSheetPresented.toggle()
                                }
                                .modifier(ButtonDesign())
                                .buttonStyle(.bordered)
                                .sheet(isPresented: $isAddBackupSheetPresented) {
                                    AddBackpack(isBackpackAdded: $isBackpackAdded, isAddDriveSheetPresented: $isAddBackupSheetPresented) // Pass the binding
                                }
                EditButton().buttonStyle(.bordered)
            }
            List {
                /// ForEach requires each element in the collection it traverses to be Identifiable
                ForEach(manager.backpacks) {
                    backpack in
                    VStack (alignment: .leading) {
                        Text(backpack.name)
                            .font(.largeTitle)
                        Text(backpack.description)
                            .font(.caption)
                    }
                }.onDelete {
                    offset in
                    manager.backpacks.remove(atOffsets: offset)
                } .onMove {
                    offset, index in
                    manager.backpacks.move(fromOffsets: offset,
                                            toOffset: index)
                }
            }
        }
    }
}

struct AddBackpack: View {
    @SceneStorage("backpackName") var backpackName: String = ""
    @SceneStorage("backpackDescription") var backpackDescription: String = ""
    @EnvironmentObject var manager: BackpackManager
    
    // Add a binding to track whether a new backpack has been added
    @Binding var isBackpackAdded: Bool
    @Binding var isAddDriveSheetPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Backpack Submission")
                        .bold()
                        .font(.largeTitle)
                }
                .padding(.bottom, 30)
    
                HStack {
                    Text("Backpack Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Backup name", text: $backpackName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Backpack Description")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                TextEditor(text: $backpackDescription)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.backpacks.append(Backpack(name: backpackName, description: backpackDescription))
                    backpackName = ""
                    backpackDescription = ""
                    
                    // Set isBackpackAddes to true to indicate a new backpack has been added
                    isBackpackAdded = true
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
                isBackpackAdded = false
            }
        }
    }
}
