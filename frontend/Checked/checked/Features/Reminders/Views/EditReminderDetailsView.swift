import SwiftUI

struct EditReminderDetailsView: View {
    enum Field: Hashable {
        case title
        case note
    }
    
    enum Mode {
        case add
        case edit
    }
    
    var mode: Mode = .add
    
    @FocusState
    private var focusedField: Field?
    
    @State var reminder = Reminder(title:"")
    
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
                    .onSubmit {
                        if !reminder.title.isEmpty {
                            commit()
                        }
                    }
                TextField("Note", text: $reminder.note, axis: .vertical)
                    .focused($focusedField, equals: .note)
                    .lineLimit(5, reservesSpace: true)
                    .onSubmit {
                        if !reminder.title.isEmpty {
                            commit()
                        }
                    }
            }
            .navigationTitle(mode == .add ? "Add reminder" : "Details")
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
    struct Container: View {
        @State var reminder = Reminder.samples[0]
        var body: some View {
            EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                print("You edited a reminder: \(reminder.title)")
            }
        }
    }
    
    static var previews: some View {
        EditReminderDetailsView { reminder in
            print("New reminder added \(reminder.title)")
        }
        Container()
    }
}
