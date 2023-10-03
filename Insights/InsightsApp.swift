//
//  InsightsApp.swift
//  Insights
//
//  Created by Drew McCormack on 03/10/2023.
//

import SwiftUI
import SwiftData

@main
struct InsightsApp: App {
    
    var modelContainer: ModelContainer = {
        let schema = Schema([Insight.self])
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
