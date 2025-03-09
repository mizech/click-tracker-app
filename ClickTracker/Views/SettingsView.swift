import SwiftUI

struct SettingsView: View {
    @Binding var isSettingsShown: Bool
    @Binding var step: Double // Actual value is a Double.
    @Binding var unit: String
    
    @State private var strStep = "" // Binding-value becomes declared as String.
    @State private var isFormInvalid = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Unit of measurement") {
                    TextField("Gram, liter, Car, Pedestrian ...", text: $unit)
                }
                Section("Step length") {
                    TextField("1, 5, 31.1, 0.75 ...", text: $strStep)
                        .keyboardType(.decimalPad)
                        .font(.title)
                }
                if isFormInvalid == true { // Handling an in-/valid form.
                    Section("Invalid data") {
                        Text("Step length")
                            .frame(alignment: .center)
                            .foregroundStyle(.red)
                            .bold()
                    }
                } else {
                    Section {
                        Button {
                            isSettingsShown.toggle()
                        } label: {
                            Text("Submit")
                                .padding()
                                .frame(height: 40)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close", systemImage: "xmark.circle") {
                        isSettingsShown.toggle()
                    }
                }
            }.navigationTitle("Settings")
        }.onAppear() {
            UITextField.appearance().clearButtonMode = .whileEditing
            strStep = "\(step)"
        }.onChange(of: strStep) {
            strStep = strStep.replacingOccurrences(of: ",", with: ".")
            if let dblStep =  Double(strStep) { // If the temporary String-value can become casted to a double ...
                isFormInvalid = false
                step = dblStep // ... the actual value becomes set to the casted value.
            } else {
                isFormInvalid = true // Otherwise the form becomes declared as invalid.
            }
        }
    }
}

#Preview {
    SettingsView(
        isSettingsShown: .constant(true),
        step: .constant(1.0),
        unit: .constant(
            "Objekt"
        )
    )
}
