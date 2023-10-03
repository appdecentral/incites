//
//  ContentView.swift
//  Insights
//
//  Created by Drew McCormack on 03/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var insights: [Insight]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(insights) { insight in
                    NavigationLink {
                        Text("Item at \(insight.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(insight.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))
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
            let newItem = Insight()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(insights[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Insight.self, inMemory: true)
}
