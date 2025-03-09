import SwiftData
import SwiftUI

struct NotesListView: View {
    @Environment(\.modelContext) var context
    @AppStorage("unit") private var unit = "Objects"
    @Query(sort: \Note.createdAt) var notes: [Note]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NavigationLink {
                    NoteDetailsView()
                } label: {
                    HStack {
                        Text(note.createdAt, format: .dateTime)
                            .bold()
                        Text("^[\(note.counter) \(note.unit)](inflect: true)")
                    }
                }
            }.onDelete { indexSet in
                for index in indexSet {
                    context.delete(notes[index])
                }
            }
        }.listStyle(.plain)
            .navigationTitle("Notes")
    }
}

#Preview {
    NotesListView()
}
