import SwiftUI

struct InsertNoteView: View {
    @Binding var isInsertNoteSheetShown: Bool
    @State var currText = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Description") {
                    TextField("Enter a description (optional)", text: $currText)
                }
                Section {
                    Button {
                        isInsertNoteSheetShown.toggle()
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
    InsertNoteView(isInsertNoteSheetShown: .constant(false))
}
