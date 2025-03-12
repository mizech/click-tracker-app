import SwiftData
import SwiftUI

struct SettingsView: View {
    @AppStorage("title") private var title = "Counting units"
    @AppStorage("counter") private var counter: Double = 0
    @AppStorage("unit") private var unit = "unit"
    @AppStorage("step") private var step = 1.0
    
    @Environment(\.modelContext) private var context
    
    @State private var isResetCounterConfirmShown = false
    @State private var isDeleteNotesConfirmShown = false
    @State private var strStep = "1"
    @State private var isFormInvalid = false
    @State private var isPopoverVisible = false
    @State private var popOverTitle = "Reset done"
    @State private var popOverMessage = ""
    
    var body: some View {
        Form {
            Section("Title (name your counting)") {
                TextField("Example: Cars passing on dd.mm.yyyy", text: $title)
            }
            Section("Unit of measurement (singular)") {
                TextField("Gram, liter, Car, Pedestrian ...", text: $unit)
            }
            Section("Step length (integer or decimal number)") {
                TextField("1, 5, 31.1, 0.75 ...", text: $strStep)
                    .keyboardType(.decimalPad)
                    .font(.title)
            }
            if isFormInvalid == true {
                Section("Invalid data") {
                    Text("Step length")
                        .frame(alignment: .center)
                        .foregroundStyle(.red)
                        .bold()
                }
            }
            Section("Reset") {
                LargeButtonView(
                    caption: "Counter to 0",
                    sysImg: "0.circle",
                    bgColor: .orange
                ) {
                    isResetCounterConfirmShown.toggle()
                }
                LargeButtonView(
                    caption: "Delete notes",
                    sysImg: "trash.circle",
                    bgColor: .red
                ) {
                    isDeleteNotesConfirmShown.toggle()
                }
            }
        }.confirmationDialog(
            "Are you sure?",
            isPresented: $isResetCounterConfirmShown
        ) {
            Button("Reset current counter?", role: .destructive) {
                counter = 0
                popOverMessage = "The counter is now 0."
                isPopoverVisible.toggle()
            }
            Button("Cancel", role: .cancel) {
                isResetCounterConfirmShown.toggle()
            }
        }.confirmationDialog("Are you sure?", isPresented: $isDeleteNotesConfirmShown) {
            Button("Delete all notes?", role: .destructive) {
                do {
                    try context.delete(model: Note.self)
                    try context.save()
                    popOverMessage = "The notes-list is now empty."
                    isPopoverVisible.toggle()
                } catch {
                    print(error)
                }
            }
            Button("Cancel", role: .cancel) {
                isDeleteNotesConfirmShown.toggle()
            }
        }.alert(isPresented: $isPopoverVisible) {
            Alert(
                title: Text(popOverTitle),
                message: Text(
                    popOverMessage
                )
            )
        }
        .onChange(of: strStep) {
            strStep = strStep.replacingOccurrences(of: ",", with: ".")
            if let dblStep =  Double(strStep) {
                isFormInvalid = false
                step = dblStep
            } else {
                isFormInvalid = true
            }
        }.onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }
}

#Preview {
    SettingsView()
}
