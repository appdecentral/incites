//
//  IncitesView.swift
//  Incites
//
//  Created by Drew McCormack on 04/10/2023.
//

import SwiftUI
import SwiftData

struct IncitesView: View {
    @Environment(\.modelContext) private var modelContext
    
    var incites: [Incite]
    @Binding var selectedInciteId: UUID?
    @Binding var selectedCategory: Category?

    var body: some View {
        List(selection: $selectedInciteId) {
            ForEach(incites, id: \.id) { incite in
                NavigationLink(value: incite.id) {
                    Text(incite.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteIncites)
        }
        .navigationTitle("Incites")
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
    }

    private func addIncite() {
        withAnimation {
            let fetchDescriptor = FetchDescriptor<Category>(predicate: #Predicate { $0.id == "ALL" })
            let allCategory: Category = try! modelContext.fetch(fetchDescriptor).first!
            
            let newIncite = Incite()
            newIncite.categories.append(allCategory)
            if let selectedCategory, selectedCategory !== allCategory {
                newIncite.categories.append(selectedCategory)
            }
            
            modelContext.insert(newIncite)
            selectedInciteId = newIncite.id
        }
    }

    private func deleteIncites(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(incites[index])
            }
        }
    }
}

//#Preview {
//    IncitesView(selectedInciteId: .constant(nil))
//}
