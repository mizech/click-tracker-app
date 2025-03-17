import SwiftUI

struct ContentView: View {
    @AppStorage("title") private var title = "Counting units"
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var unit = "unit"
    @AppStorage("step") private var step = 1.0
    
    @Environment(\.modelContext) var context
    
    @State var selection = 1
    @State private var isInsertNoteSheetShown = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                VStack {
                    Text("^[\(counter, specifier: "%.2f") \(unit)](inflect: true)").font(.largeTitle)
                    Spacer()
                    CountButtonView(
                        counter: $counter,
                        caption: String(format: "%.2f", step),
                        sysImg: "plus",
                        bgColor: .blue
                    ) {
                        counter += step
                    }.padding(.bottom)
                    CountButtonView(
                        counter: $counter,
                        caption: String(format: "%.2f", step),
                        sysImg: "minus",
                        bgColor: .cyan
                    ) {
                        guard counter - step >= 0 else {
                            return
                        }
                        counter -= step
                    }
                    Spacer()
                    LargeButtonView(
                        caption: "Add note",
                        sysImg: "note.text.badge.plus",
                        bgColor: .green
                    ) {
                        isInsertNoteSheetShown.toggle()
                    }
                    Spacer()
                }
                .padding()
                .tabItem {
                    Label(String(format: NSLocalizedString("Clicker", comment: "")), systemImage: "hand.tap.fill")
                }.tag(1)
                NotesListView()
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }.tag(2)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }.tag(3)
            }.navigationTitle(selection == 3 ? "Settings" : title)
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: step, { oldValue, newValue in
                    if newValue <= 0 {
                        step = oldValue
                    }
                })
                .sheet(isPresented: $isInsertNoteSheetShown, content: {
                    InsertNoteView(isInsertNoteSheetShown: $isInsertNoteSheetShown, counter: counter)
                })
        }
    }
}

#Preview {
    ContentView()
}
