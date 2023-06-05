import SwiftUI

struct RemindersListRowView: View {
    @Binding
    var reminder: Reminder
    
    var body: some View {
        let hasNote = !reminder.note.isEmpty
        
        HStack(alignment: hasNote ? .top : .center) {
            Toggle(isOn: $reminder.isCompleted) {}
                .toggleStyle(.reminder)
            VStack(alignment: hasNote ? .leading : .center, spacing: hasNote ? 3 : 0) {
                Text(reminder.title)
                    .strikethrough(reminder.isCompleted)
                if hasNote {
                    Text(reminder.note)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct RemindersListRowView_Previews: PreviewProvider {
    struct Container: View {
        @State var reminder = Reminder.samples[Reminder.samples.count - 1]
        var body: some View {
            List {
                RemindersListRowView(reminder: $reminder)
            }
            .listStyle(.plain)
        }
    }
        
  static var previews: some View {
      NavigationView {
          Container()
              .navigationTitle("Reminders")
      }
  }
}
