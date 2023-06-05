import Foundation
import FirebaseFirestoreSwift

struct Reminder: Identifiable, Codable {
    @DocumentID
    var id: String?
    var title: String
    var note = ""
    var isCompleted = false
    var userId: String? = nil
}

extension Reminder {
    static let collectionName = "reminders"
}

extension Reminder {
    static let samples = [
        Reminder(title: "Install XCode", isCompleted: true),
        Reminder(title: "Create a new project", isCompleted: true),
        Reminder(title: "Create a Github repo"),
        Reminder(title: "Create first screen"),
        Reminder(title: "Commit to GitHub"),
        Reminder(title: "Do moreeeee!", note: "Learn more stuff and build shit"),
    ]
}
