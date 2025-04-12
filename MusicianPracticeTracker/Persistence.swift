//
//  Persistence.swift
//  MusicianPracticeTracker
//
//  Created by Igor Odaryuk on 12.04.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MusicianPracticeTracker")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load Core Data store: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
