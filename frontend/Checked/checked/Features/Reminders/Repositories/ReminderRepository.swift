import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReminderRepository: ObservableObject {
    @Published var reminders = [Reminder]()
    
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }

    func subscribe() {
        if listenerRegistration == nil {
            let query = Firestore.firestore().collection(Reminder.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    self?.reminders = documents.compactMap { queryDocumentSnapshot in
                        do {
                            return try queryDocumentSnapshot.data(as: Reminder.self)
                        } catch {
                            print("Error while trying to map document \(queryDocumentSnapshot.documentID) to Reminder struct: \(error.localizedDescription)")
                            return nil
                        }
                    }
                }
        }
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func addReminder(_ reminder: Reminder) throws {
        try Firestore
            .firestore()
            .collection("reminders")
            .addDocument(from: reminder)
    }
}
