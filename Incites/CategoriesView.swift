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
    
    @Binding var selectedCategoryId: String?
    
    var body: some View {
        List(selection: $selectedCategoryId) {
            ForEach(categories, id: \.id) { category in
                NavigationLink(value: category.id) {
                    Text(category.textLabel)
                }
            }
        }
        .navigationTitle("Categories")
        .onAppear {
            if categories.isEmpty {
                let all = Category(id: "ALL")
                all.sortPriority = 1
                all.textLabel = "All Incites"
                all.color = .blue
                modelContext.insert(all)
            }
            selectedCategoryId = "ALL"
        }
    }
}
