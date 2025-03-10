import SwiftUI

struct SettingsView: View {
    @AppStorage("counter") private var counter: Double = 0
    
    @State private var isResetCounterConfirmShown = false
    
    var body: some View {
        Form {
            Button {
                isResetCounterConfirmShown.toggle()
            } label: {
                Label("Reset counter", systemImage: "0.circle")
                    .padding()
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .roundedCorners()
            }
        }.confirmationDialog(
            "Are you sure?",
            isPresented: $isResetCounterConfirmShown
        ) {
            Button("Reset counter to 0", role: .destructive) {
                counter = 0
            }
            Button("Cancel", role: .cancel) {
                isResetCounterConfirmShown.toggle()
            }
        }
    }
}

#Preview {
    SettingsView()
}
