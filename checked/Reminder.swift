import Foundation

struct Reminder: Identifiable {
    var id = UUID();
    var title: String;
    var isCompleted = false;
}

extension Reminder {
    static let samples = [
        Reminder(title: "Install XCode", isCompleted: true),
        Reminder(title: "Create a new project", isCompleted: true),
        Reminder(title: "Create a Github repo"),
        Reminder(title: "Create first screen"),
        Reminder(title: "Commit to GitHub"),
        Reminder(title: "Do moreeeee!"),
    ]
}
