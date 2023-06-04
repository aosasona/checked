import SwiftUI

struct AddReminderView: View {
    enum Field: Hashable {
        case title
        case note
    }
    
    @FocusState
    private var focusedField: Field?
    
    @State private var reminder = Reminder(title:"")
    
    @Environment(\.dismiss)
    private var dismiss
    
    var onCommit: (_ reminder: Reminder) -> Void
    
    private func commit() {
        onCommit(reminder)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
                TextField("Note", text: $reminder.note, axis: .vertical)
                    .focused($focusedField, equals: .note)
                    .lineLimit(5, reservesSpace: true)
            }
            .navigationTitle("Add reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: commit) {
                        Text("Add")
                    }
                    .disabled(reminder.title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                }
            }
            .onAppear() {
                focusedField = .title
            }
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView { reminder in
            print("New reminder added \(reminder.title)")
        }
    }
}
