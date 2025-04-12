//
//  MusicianPracticeTrackerApp.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import SwiftUI
import CoreData

@main
struct MusicianPracticeTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

