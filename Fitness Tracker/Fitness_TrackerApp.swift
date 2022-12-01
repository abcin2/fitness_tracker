//
//  Fitness_TrackerApp.swift
//  Fitness Tracker
//
//  Created by Robert Alec Hovey on 11/30/22.
//

import SwiftUI

@main
struct Fitness_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
