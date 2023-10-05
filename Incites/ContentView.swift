//
//  ContentView.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import SwiftUI
import SwiftData
import CoreSpotlight

struct ContentView: View {
    @State var selectedInciteId: UUID?
    @State var selectedCategory: Category?
    @Query(sort: \Incite.creationDate, order: .forward) var incites: [Incite]
    @Query(sort: [SortDescriptor(\Category.isBuiltInForSorting, order: .reverse), SortDescriptor(\Category.textLabel)]) 
    var categories: [Category]
    
    var body: some View {
        NavigationSplitView {
            IncitesView(incites: incites, selectedInciteId: $selectedInciteId, selectedCategory: $selectedCategory)
        } detail: {
            if let selectedInciteId, let incite = incites.first(where: { $0.id == selectedInciteId }) {
                EditInciteView(incite: incite)
            } else {
                Text("Select a Category")
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Incite.self, inMemory: true)
}
