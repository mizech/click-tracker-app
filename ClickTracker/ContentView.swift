import SwiftUI

struct ContentView: View {
    @State private var isSettingsShown = false
    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    
                }.tabItem {
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
