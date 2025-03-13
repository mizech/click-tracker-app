import SwiftData
import SwiftUI

struct NoteDetailsView: View {
    var note: Note
    
    @Environment(\.modelContext) var context
    
    @State var isEditSheetShown = false
    @State var currText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Counter: \(String(format: "%.2f", note.counter)) \(note.unit)")
                .font(.title)
            if note.text.count > 0 {
                Text("Note: \(note.text)")
                    .font(.title2)
            }
            Text("Used step length: \(String(format: "%.2f", note.step))")
                .font(.subheadline)
            Text("Created: \(note.createdAt.formatted(date: .complete, time: .shortened))")
                .font(.subheadline)
            Text("Modified: \(note.modifiedAt.formatted(date: .complete, time: .shortened))")
                .font(.subheadline)
            Spacer()
        }.padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditSheetShown.toggle()
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .sheet(isPresented: $isEditSheetShown) {
                NavigationStack {
                    Form {
                        Section("Description") {
                            TextField("Enter a description (optional)", text: $currText)
                        }
                        Section {
                            Button {
                                note.text = currText
                                
                                do {
                                    try context.save()
                                    isEditSheetShown.toggle()
                                } catch {
                                    print(error)
                                }
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
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                isEditSheetShown.toggle()
                            } label: {
                                Label("Close", systemImage: "heart")
                            }

                        }
                    }
                }            }
            .onAppear() {
                currText = note.text
            }
    }
}

#Preview {
    NoteDetailsView(
        note: Note(
            text: "Text_001",
            counter: 0,
            step: 1.0,
            unit: "Gram"
        )
    )
}
