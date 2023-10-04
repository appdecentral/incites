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
    @Environment(\.modelContext) private var modelContext
    @Query private var incites: [Incite]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(incites) { incite in
                    NavigationLink {
                        Text("Item at \(incite.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(incite.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addIncite) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onContinueUserActivity(CSSearchableItemActionType, perform: handleSpotlight)
    }

    private func addIncite() {
        withAnimation {
            let newItem = Incite()
            let tag = Tag()
            tag.textLabel = "Car"
            newItem.tags.append(tag)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(incites[index])
            }
        }
    }
    
    func handleSpotlight(userActivity: NSUserActivity) {
        guard let identifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String else {
            return
        }
        
        print("Item tapped: \(identifier)")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Incite.self, inMemory: true)
}
