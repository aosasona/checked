import Foundation
import Factory
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Container {
    public var useEmulator: Factory<Bool> {
        self {
            let value = UserDefaults.standard.bool(forKey: "useEmulator")
            return value
        }.singleton
    }
    
    public var firestore: Factory<Firestore> {
        self {
            var environment = ""
            
            if Container.shared.useEmulator() {
                let settings = Firestore.firestore().settings
                settings.host = "localhost:8080"
                settings.isSSLEnabled = false
                settings.cacheSettings = MemoryCacheSettings()
                environment = "using local emulator on \(settings.host)"
                
                Firestore.firestore().settings = settings
                Auth.auth().useEmulator(withHost: "localhost", port: 9099)
            } else {
                environment = "using the Firebase prod backend"
            }
            print("Configuring Cloud Firestore: \(environment)")
            return Firestore.firestore()
        }.singleton
    }
}
