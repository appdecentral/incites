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
    @Query(filter: #Predicate<Incite> { _ in false }, sort: \Incite.creationDate, order: .forward) var incites: [Incite]
    
    @Binding var selectedInciteId: UUID?
    var selectedCategoryId: String?

    init(selectedInciteId: Binding<UUID?>, selectedCategoryId: String?) {
        self._selectedInciteId = selectedInciteId
        self.selectedCategoryId = selectedCategoryId
        
        if let selectedCategoryId {
            let predicate = #Predicate<Incite> { incite in
                incite.categories!.contains(where: { $0.id == selectedCategoryId })
            }
            self._incites  = Query(filter: predicate, sort: \Incite.creationDate)
        } else {
            let predicate = #Predicate<Incite> { _ in false }
            self._incites  = Query(filter: predicate, sort: \Incite.creationDate)
        }
    }
    
    var body: some View {
        List(selection: $selectedInciteId) {
            ForEach(incites, id: \.id) { incite in
                NavigationLink(value: incite.id) {
                    InciteRowView(incite: incite, selectedInciteId: selectedInciteId)
                }
            }
            .onDelete(perform: deleteIncites)
        }
        .navigationTitle("Incites")
        .toolbar {
            ToolbarItem {
                Button(action: addIncite) {
                    Label("Add Incite", systemImage: "plus")
                }
            }
        }
    }

    private func addIncite() {
        withAnimation {
            let descriptor = FetchDescriptor<Category>(predicate:
                #Predicate {
                    $0.id == "ALL" || $0.id == (selectedCategoryId ?? "")
                }
            )
            let fetchedCategories: [Category] = try! modelContext.fetch(descriptor)
            
            let newIncite = Incite()
            newIncite.categories = fetchedCategories
            
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


struct InciteRowView: View {
    var incite: Incite
    var selectedInciteId: UUID?
    
    var body: some View {
        if incite.fact.text.isEmpty {
            HStack {
                Text("Newly created on:")
                Text(incite.creationDate, format: Date.FormatStyle(date: .numeric))
            }
            .opacity(selectedInciteId == incite.id ? 1.0 : 0.5)
        } else {
            Text(incite.fact.text)
                .lineLimit(1)
        }
    }
}
