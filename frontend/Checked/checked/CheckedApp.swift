import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Factory

class AppDelegate: NSObject, UIApplicationDelegate {
    @LazyInjected(\.authenticationService)
    private var authenticationService
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        authenticationService.signInAnonymously()
        
        return true
    }
}

@main
struct CheckedApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RemindersListView()
                    .navigationTitle("Reminders")
            }
        }
    }
}
