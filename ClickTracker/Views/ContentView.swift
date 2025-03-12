import SwiftUI

struct ContentView: View {
    @AppStorage("title") private var title = "Counting units"
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var unit = "unit"
    @AppStorage("step") private var step = 1.0
    
    @Environment(\.modelContext) var context
    
    @State private var isInsertNoteSheetShown = false
    
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
                        bgColor: .green
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
            .navigationTitle(title)
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
