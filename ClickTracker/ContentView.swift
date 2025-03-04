import SwiftUI

struct ContentView: View {
    @State private var isSettingsShown = false
    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("X units of Y")
                        .font(.largeTitle)
                    Spacer()
                    LargeButtonView(caption: "Increment", sysImg: "plus", bgColor: .blue) {
                        
                    }.padding(.bottom)
                    LargeButtonView(caption: "Decrement", sysImg: "minus", bgColor: .orange) {
                        
                    }
                    Spacer()
                    LargeButtonView(caption: "Create note", sysImg: "note.text.badge.plus", bgColor: .green) {
                        
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
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gear") {
                        isSettingsShown.toggle()
                    }
                }
            }.sheet(isPresented: $isSettingsShown) {
                Text("Settings")
            }
        }
    }
}

#Preview {
    ContentView()
}
