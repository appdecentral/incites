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
    @State var selectedCategoryId: UUID?
    
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
