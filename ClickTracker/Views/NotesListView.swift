import SwiftData
import SwiftUI

struct NotesListView: View {
    @Environment(\.modelContext) var context
    @AppStorage("unit") private var unit = "Objects"
    @Query(sort: \Note.createdAt) var notes: [Note]
    
    var body: some View {
        Group {
            if notes.count > 0 {
                List {
                    ForEach(notes) { note in
                        NavigationLink {
                            NoteDetailsView(note: note)
                        } label: {
                            HStack {
                                Text(note.createdAt, format: .dateTime)
                                    .bold()
                                Text("^[\(String(format: "%.2f", note.counter)) \(note.unit)](inflect: true)")
                            }
                        }
                    }.onDelete { indexSet in
                        for index in indexSet {
                            context.delete(notes[index])
                        }
                    }
                }.listStyle(.plain)
            } else {
                VStack {
                    Label("There are no notes.", systemImage: "clipboard")
                }
            }
        }
        .navigationTitle("Notes")
    }
}

#Preview("English") {
    NotesListView()
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("German") {
    NotesListView()
        .environment(\.locale, Locale(identifier: "DE"))
}
