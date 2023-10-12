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
        .modelContainer(modelContainer ?? inMemoryContainer)
    }
    
    var modelContainer: ModelContainer? = {
        do {
            let schema = Schema(CurrentVersionedSchema.models, version: CurrentVersionedSchema.versionIdentifier)
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try ModelContainer(for: schema, migrationPlan: IncitesMigrationPlan.self, configurations: [config])
        } catch {
            print("Failed to create model with error: \(error)")
            return nil
        }
    }()
    
    var inMemoryContainer: ModelContainer = {
        let schema = Schema(CurrentVersionedSchema.models, version: CurrentVersionedSchema.versionIdentifier)
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try! ModelContainer(for: schema, migrationPlan: IncitesMigrationPlan.self, configurations: [config])
    }()
    
}
