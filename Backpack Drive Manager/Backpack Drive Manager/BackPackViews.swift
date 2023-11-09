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
                // TODO: Model 3 - Add the onMove method below
            }
        }
    }
}

struct BackpackInfo: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Crosswalk")) {
                        NavigationLink(destination: Text("Name of the crosswalk")) {
                            Text("Crosswalk name")
                        }
                        NavigationLink(destination: Text("Address of the crosswalk")) {
                            Text("Crosswalk address")
                        }
                    }
                    Section(header: Text("Volunteer")) {
                        NavigationLink(destination: Text("Name of the volunteer")) {
                            Text("Volunteer")
                        }
                        DisclosureGroup(content: {
                            NavigationLink(destination: Text("Minors can only volunteer for 1 hour and accompanied by an adult.")) {
                                Text("Minors")
                            }
                            NavigationLink(destination: Text("Adults can volunteer for a maximum of 3 hours.")) {
                                Text("Adults")
                            }
                            NavigationLink(destination: Text("Seniors can volunteer for a maximum of 2 hours.")) {
                                Text("Seniors")
                            }
                        }) {
                            Text("Maximum hours")
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct AddBackpack: View {
    @SceneStorage("crosswalkName") var crosswalkName: String = ""
    @SceneStorage("crosswalkAddress") var crosswalkAddress: String = ""
    @EnvironmentObject var manager: BackpackManager
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                Text("Crosswalk Submission")
                    .bold()
                    .font(.largeTitle)
                }
                .padding(.bottom, 30)

                HStack {
                    Text("Crosswalk Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Crosswalk name", text: $crosswalkName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Crosswalk address")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                TextEditor(text: $crosswalkAddress)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.crosswalks.append(Backpack(name: crosswalkName, description: crosswalkAddress))
                    crosswalkName = ""
                    crosswalkAddress = ""
                }) {
                    Text("Submit")
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
            .padding()
        }
    }
}
