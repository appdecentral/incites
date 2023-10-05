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
    @State var selectedCategoryId: String?
    
    var body: some View {
        NavigationSplitView {
            CategoriesView(selectedCategoryId: $selectedCategoryId)
        } content: {
            IncitesView(selectedInciteId: $selectedInciteId, selectedCategoryId: selectedCategoryId)
        } detail: {
            EditInciteView(inciteId: selectedInciteId)
        }
    }
    
}

#Preview {
    ContentView(selectedInciteId: nil, selectedCategoryId: nil)
        .modelContainer(for: [Incite.self, Category.self, InciteImage.self], inMemory: true)
}
