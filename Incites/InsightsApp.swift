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
        let schema = Schema([Incite.self, InciteImage.self, Category.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [config])
    }()
    
}
