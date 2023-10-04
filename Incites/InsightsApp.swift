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
    
    var modelContainer: ModelContainer = {
        let schema = Schema([Incite.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try! ModelContainer(for: schema, configurations: [config])
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
    
}
