import SwiftUI

struct RemindersListView: View {
    @StateObject private var viewModel = RemindersListViewModel()
    
    @State private var isAddReminderDialogShown = false
    @State private var editableReminder: Reminder? = nil
    
    
    private func showAddReminderDialog() {
        isAddReminderDialogShown.toggle()
    }
    
    @State private var isSettingsScreenShown = false
    private func showSettingsScreen() {
        isSettingsScreenShown.toggle()
    }
    
    var body: some View {
        NavigationStack {
            List ($viewModel.reminders) { $reminder in
                RemindersListRowView(reminder: $reminder)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive, action: { viewModel.deleteReminder(reminder) }) {
                           Image(systemName: "trash")
                        }
                        .tint(Color(UIColor.systemRed))
                    }
                    .onChange(of: reminder.isCompleted) { newIsCompleted in
                        viewModel.updateCompleted(reminder, isCompleted: newIsCompleted)
                    }
                    .onTapGesture {
                        editableReminder =  reminder
                    }
            }
            .toolbar() {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: showSettingsScreen) {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItemGroup (placement: .bottomBar) {
                    Spacer()
                    Button(action: showAddReminderDialog) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text ("Add reminder")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddReminderDialogShown) {
                EditReminderDetailsView { reminder in
                    viewModel.addReminder(reminder)
                }
            }
            .sheet(isPresented: $isSettingsScreenShown) {
                SettingsView()
            }
            .sheet(item: $editableReminder) { reminder in
                EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                    viewModel.updateReminder(reminder)
                }
            }
            .tint(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView()
    }
}
