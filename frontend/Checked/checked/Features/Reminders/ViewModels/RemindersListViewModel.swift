import Foundation

class RemindersListViewModel: ObservableObject {
    @Published
    var reminders = Reminder.samples
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func toggleCompleted(_ reminder: Reminder) {
        // $0 is the first parameter passed to the closure abstracted here as { }
        if let idx = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[idx].isCompleted.toggle()
        }
    }
}
