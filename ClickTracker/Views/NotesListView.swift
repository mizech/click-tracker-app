import SwiftData
import SwiftUI

struct NotesListView: View {
    @Environment(\.modelContext) var context
    @AppStorage("entityName") private var entityName = "Objects"
    @Query(sort: \Note.createdAt) var notes: [Note]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                HStack {
                    Text(note.createdAt, format: .dateTime)
                        .bold()
                    Text("\(note.counter) \(note.entityName)")
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
