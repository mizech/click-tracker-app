import SwiftUI

struct ContentView: View {
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var entityName = "Objects"
    @AppStorage("step") private var step = 1.0
    
    @State private var isSettingsSheetShown = false
    @State private var isInsertNoteSheetShown = false
    @State private var isCounterResetConfirmShown = false
    
    let numFormatter = NumberFormatter()
    
    init() {
        numFormatter.numberStyle = .decimal
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text(String(format: "%.2f", counter))
                        .font(.system(size: 48))
                    Text("\(entityName)")
                        .font(.system(size: 32))
                    Spacer()
                    LargeButtonView(
                        counter: $counter,
                        caption: String(format: "%.2f", step),
                        sysImg: "plus",
                        bgColor: .blue
                    ) {
                        counter += step
                    }.padding(.bottom)
                    LargeButtonView(
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
                    
                }
                .padding()
                .tabItem {
                    Label("Clicker", systemImage: "hand.tap.fill")
                }
                List {
                    
                }.tabItem {
                    Label("Notes", systemImage: "note.text")
                }
            }
            .onChange(of: step, { oldValue, newValue in
                if newValue <= 0 {
                    step = oldValue
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset count", systemImage: "0.circle") {
                        isCounterResetConfirmShown.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gear") {
                        isSettingsSheetShown.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create note", systemImage: "note.text.badge.plus") {
                        isInsertNoteSheetShown.toggle()
                    }
                }
            }.sheet(isPresented: $isSettingsSheetShown) {
                SettingsView(
                    isSettingsShown: $isSettingsSheetShown,
                    step: $step,
                    entityName: $entityName
                )
            }.sheet(isPresented: $isInsertNoteSheetShown, content: {
                Text("Insert Note")
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
