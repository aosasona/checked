import SwiftUI

struct RemindersListView: View {
    @StateObject
    private var viewModel = RemindersListViewModel()
    
    @State
    private var isAddReminderDialogShown = false
    
    
    private func showAddReminderDialog() {
        isAddReminderDialogShown.toggle()
    }
    
    var body: some View {
        NavigationStack {
            List ($viewModel.reminders) { $reminder in
                RemindersListRowView(reminder: $reminder)
            }
            .toolbar() {
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
                AddReminderView { reminder in
                    viewModel.addReminder(reminder)
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
