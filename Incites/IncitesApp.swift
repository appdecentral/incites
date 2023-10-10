//
//  IncitesApp.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import SwiftUI
import SwiftData

@main
struct IncitesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
    
    var modelContainer: ModelContainer = {
        do {
            let schema = Schema([Incite.self], version: .init(1, 1, 0))
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try ModelContainer(for: schema, migrationPlan: IncitesMigrationPlan.self, configurations: [config])
        } catch {
            fatalError("Failed to create model with error: \(error)")
        }
    }()
    
}
