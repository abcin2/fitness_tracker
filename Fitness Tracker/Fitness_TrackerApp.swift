import SwiftUI

@main
struct Fitness_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // MARK: Used for testing
            TestDataView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            // MARK: Used for prod
            // ContentView()
                // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
