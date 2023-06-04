import Foundation
import Combine

class RemindersListViewModel: ObservableObject {
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String?
    
    private var remindersRepository: ReminderRepository = ReminderRepository()
    
    init() {
        remindersRepository
            .$reminders
            .assign(to: &$reminders)
    }
    
    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleCompleted(_ reminder: Reminder) {
        // $0 is the first parameter passed to the closure abstracted here as { }
        if let idx = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[idx].isCompleted.toggle()
        }
    }
}
