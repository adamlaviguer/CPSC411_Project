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
       //         ForEach(manager.backpacks) {
        //            backpack in
                ForEach(manager.backpacks.sorted(by: { $0.available > $1.available })){
                    backpack in
                    VStack (alignment: .leading) {
                        Text(backpack.name)
                            .font(.largeTitle)
                        Text(String(backpack.available)+" available")
                        Text(backpack.description)
                            .font(.caption)
                        HStack{
                             Button("+"){
                                //incFunc(for: backpack)
                                incFunc(for: backpack, in: manager)
                            }
                            .buttonStyle(.bordered)
                            Button("-"){
                                //incFunc(for: backpack)
                                decFunc(for: backpack, in: manager)
                            }
                            .buttonStyle(.bordered)
                        }

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
private func incFunc(for backpack: Backpack, in manager: BackpackManager) {
    if let index = manager.backpacks.firstIndex(where: { $0.id == backpack.id }) {
        manager.backpacks[index].available += 1
    }
}
private func decFunc(for backpack: Backpack, in manager: BackpackManager) {
    if let index = manager.backpacks.firstIndex(where: { $0.id == backpack.id }) {
        manager.backpacks[index].available -= 1
    }
}
struct AddBackpack: View {
    @State private var backpackName: String = ""
    @State private var backpackDescription: String = ""
    @State private var backpackAvail: Int = 0 // Use String for TextField
    @EnvironmentObject var manager: BackpackManager
    
    // Add a binding to track whether a new backpack has been added
    @Binding var isBackpackAdded: Bool
    @Binding var isAddDriveSheetPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
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
                        Text("Backpack Availability")
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    HStack {
                        TextField("How many backpacks are available?", text: Binding(
                            get: { String(backpackAvail) },
                            set: { backpackAvail = Int($0) ?? 0 }
                        ))
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Backpack Description")
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        TextEditor(text: $backpackDescription)
                            .modifier(TextEntry())
                            .frame(minHeight: 100)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        Button(action: {
                            manager.backpacks.append(Backpack(name: backpackName,
                                    description: backpackDescription, available: backpackAvail))
                            backpackName = ""
                            backpackDescription = ""
                            backpackAvail = 0
                            
                            // Set isBackpackAdded to true to indicate a new backpack has been added
                            isBackpackAdded = true
                            isAddDriveSheetPresented = false
                        }) {
                            Text("Submit")
                                .modifier(submitDesign())
                        }
                    }

                }
            }
            .padding()
            //.keyboardAdaptive()
            .onDisappear {
                // Automatically close the sheet when the view disappears
                isBackpackAdded = false
            }
        }
    }

}
