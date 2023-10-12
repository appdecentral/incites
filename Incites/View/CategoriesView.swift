//
//  CategoriesView.swift
//  Incites
//
//  Created by Drew McCormack on 05/10/2023.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Category.sortPriority, order: .reverse), SortDescriptor(\Category.textLabel)])
    var categories: [Category]
    
    @Binding var selectedCategoryId: UUID?
    
    var body: some View {
        List(selection: $selectedCategoryId) {
            ForEach(categories, id: \.uniqueId) { category in
                NavigationLink(value: category.uniqueId) {
                    Text(category.textLabel)
                }
            }
        }
        .navigationTitle("Categories")
        .onAppear {
            if categories.isEmpty {
                let all = Category()
                all.variety = .allIncites
                all.sortPriority = 1
                all.textLabel = "All Incites"
                all.color = .black
                modelContext.insert(all)
            }
            if selectedCategoryId == nil {
                selectedCategoryId = modelContext.allInsitesCategory?.uniqueId
            }
        }
    }
}
