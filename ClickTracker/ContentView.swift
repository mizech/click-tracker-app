import SwiftUI

struct ContentView: View {
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var entityName = "Objects"
    @AppStorage("step") private var step = 1.0
    
    @State private var isSettingsShown = false
    @State private var isCounterResetConfirmShown = false
    
    let numFormatter = NumberFormatter()
    
    init() {
        numFormatter.numberStyle = .decimal
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset count", systemImage: "0.circle") {
                        isCounterResetConfirmShown.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Settings", systemImage: "gear") {
                        isSettingsShown.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create note", systemImage: "note.text.badge.plus") {
                        
                    }
                }
            }.sheet(isPresented: $isSettingsShown) {
                NavigationStack {
                    Form {
                        Section("Object name") {
                            TextField("", text: $entityName)
                        }
                        
                        Section("Step length") {
                            TextField(
                                "Enter step length",
                                value: $step,
                                formatter: numFormatter
                            )
                                .keyboardType(.decimalPad)
                                .font(.title)
                        }
                    }.toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Close", systemImage: "xmark.circle") {
                                isSettingsShown.toggle()
                            }
                        }
                    }
                }
            }.confirmationDialog(
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
