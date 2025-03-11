import SwiftUI

struct ContentView: View {
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var unit = "Objects"
    @AppStorage("step") private var step = 1.0
    @Environment(\.modelContext) var context
    
    @State private var isInsertNoteSheetShown = false
    @State private var isCounterResetConfirmShown = false
    
    var body: some View {
        NavigationStack {
            TabView {
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
                        bgColor: .orange
                    ) {
                        isInsertNoteSheetShown.toggle()
                    }
                    Spacer()
                }
                .padding()
                .tabItem {
                    Label("Clicker", systemImage: "hand.tap.fill")
                }
                NotesListView()
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .onChange(of: step, { oldValue, newValue in
                if newValue <= 0 {
                    step = oldValue
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Delete notes", systemImage: "trash.circle") {
                        do {
                            try context.delete(model: Note.self)
                        } catch {
                            print(error)
                        }
                    }
                }
            }.sheet(isPresented: $isInsertNoteSheetShown, content: {
                InsertNoteView(isInsertNoteSheetShown: $isInsertNoteSheetShown, counter: counter)
            })
            .confirmationDialog(
                "Are you sure?",
                isPresented: $isCounterResetConfirmShown
            ) {
                Button("Reset counter", role: .destructive) {
                    counter = 0
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    ContentView()
}
