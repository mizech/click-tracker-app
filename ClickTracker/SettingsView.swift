import SwiftUI

struct SettingsView: View {
    @Binding var isSettingsShown: Bool
    @Binding var step: Double
    @Binding var entityName: String
    
    let numFormatter = NumberFormatter()
    
    var body: some View {
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
        }.onAppear() {
            numFormatter.numberStyle = .decimal
        }
    }
}

#Preview {
    SettingsView(
        isSettingsShown: .constant(true),
        step: .constant(1.0),
        entityName: .constant(
            "Objekt"
        )
    )
}
