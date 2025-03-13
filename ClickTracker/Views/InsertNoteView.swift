import SwiftUI

struct InsertNoteView: View {
    @AppStorage("title") private var title = "Counting units"
    @AppStorage("unit") private var unit = "Objects"
    @AppStorage("step") private var step = 1.0
    
    @Binding var isInsertNoteSheetShown: Bool
    
    @Environment(\.modelContext) var context
    
    @State var currText = ""
    
    var counter: Double
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Description") {
                    TextField("Enter a description (optional)", text: $currText)
                }
                Section {
                    Button {
                        context.insert(
                            Note(text: currText,
                                counter: counter,
                                step: step,
                                unit: unit
                            )
                        )
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                        isInsertNoteSheetShown.toggle()
                    } label: {
                        Text("Submit")
                            .padding()
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .bold()
                            .roundedCorners()
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close", systemImage: "xmark.circle") {
                        isInsertNoteSheetShown.toggle()
                    }
                }
            })
            .navigationTitle("Create Note")
        }
    }
}

#Preview {
    InsertNoteView(
        isInsertNoteSheetShown: .constant(false),
        counter: 8.0
    )
}
