//
//  ContentView.swift
//  Incites
//
//  Created by Drew McCormack on 03/10/2023.
//

import SwiftUI
import SwiftData

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
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Incite()
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
}

#Preview {
    ContentView()
        .modelContainer(for: Incite.self, inMemory: true)
}
