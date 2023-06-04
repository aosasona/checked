import SwiftUI

struct ContentView: View {
    @State
    private var reminders = Reminder.samples
    @State
    private var isAddReminderDialogShown = false
    
    private func showAddReminderDialog() {
        isAddReminderDialogShown.toggle()
    }
    
    var body: some View {
        NavigationStack {
            List ($reminders) { $reminder in
                HStack {
                    Image(systemName: reminder.isCompleted
                          ? "largecircle.fill.circle"
                          : "circle")
                    .imageScale(.medium)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        reminder.isCompleted.toggle()
                    }
                    Text(reminder.title)
                }
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
                    reminders.append(reminder)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
