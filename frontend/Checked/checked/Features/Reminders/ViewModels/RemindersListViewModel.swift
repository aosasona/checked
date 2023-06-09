import Foundation
import Factory
import Combine

class RemindersListViewModel: ObservableObject {
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String?
    
    @Injected(\.remindersRepository)
    private var remindersRepository: RemindersRepository
    
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
    
    func updateReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.updateReminder(reminder)
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func updateCompleted(_ reminder: Reminder, isCompleted: Bool) {
        // taking a copy because the reminder passed in here is immutable here by default
        var modifiedReminder = reminder
        modifiedReminder.isCompleted = isCompleted
        updateReminder(modifiedReminder)
    }
    
    func deleteReminder(_ reminder: Reminder) {
        remindersRepository.removeReminder(reminder)
    }
}
