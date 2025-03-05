import SwiftUI

struct ContentView: View {
    @AppStorage("counter") private var counter = 0
    @AppStorage("unit") private var entityName = "Objects"
    @AppStorage("step") private var step = 1
    
    @State private var isSettingsShown = false
    @State private var isCounterResetConfirmShown = false
    @State private var isSettingsResetConfirmShown = false
    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text(String(counter))
                        .font(.system(size: 48))
                    Text("\(entityName)")
                        .font(.system(size: 32))
                    Spacer()
                    LargeButtonView(
                        counter: $counter,
                        caption: "\(step)",
                        sysImg: "plus",
                        bgColor: .blue
                    ) {
                        counter += step
                    }.padding(.bottom)
                    LargeButtonView(
                        counter: $counter,
                        caption: "\(step)",
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
                        Section("Step length") {
                            TextField("Enter step length", value: $step, format: .number)
                                .keyboardType(.numberPad)
                                .font(.title)
//                            TextField("Enter object name/description", value: $entityName)
//                                .font(.title)
                        }
                        
                        Section("Actions") {
                            LargeButtonView(
                                counter: $counter,
                                caption: "Reset counter",
                                sysImg: "0.circle",
                                bgColor: .orange
                            ) {
                                isCounterResetConfirmShown.toggle()
                            }
                            LargeButtonView(
                                counter: $counter,
                                caption: "Reset settings",
                                sysImg: "bolt.trianglebadge.exclamationmark",
                                bgColor: .red
                            ) {
                                isSettingsResetConfirmShown.toggle()
                            }
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
                Button("Cancel", role: .cancel) {
                    isCounterResetConfirmShown.toggle()
                }
            }.confirmationDialog(
                "Are you sure?",
                isPresented: $isSettingsResetConfirmShown
            ) {
                Button("Reset settings", role: .destructive) {
                    counter = 0
                    entityName = "Objects"
                    step = 1
                }
                Button("Cancel", role: .cancel) {
                    isSettingsResetConfirmShown.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
