import SwiftUI

struct NoteDetailsView: View {
    var note: Note
    
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
