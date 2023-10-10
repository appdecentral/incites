//
//  CategoryGridView.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import SwiftUI
import SwiftData
import WrappingHStack

struct CategoryGridView: View {
    @Environment(\.modelContext) private var modelContext

    @Binding var incite: Incite
    @Query(sort: [SortDescriptor(\Category.sortPriority, order: .reverse), SortDescriptor(\Category.textLabel)])
    var categories: [Category]
    
    @State var addingCategory: Bool = false
    @State var newCategoryName: String = ""

    var body: some View {
        WrappingHStack {
            ForEach(categories) { category in
                let selectionBinding = Binding<Bool>(
                    get: {
                        incite.categories!.contains(category)
                    },
                    set: { newValue in
                        if newValue {
                            incite.categories!.append(category)
                        } else {
                            incite.categories = []
                        }
                    }
                )
                CategoryButton(selected: selectionBinding, label: category.textLabel, inciteColor: category.color)
                    .disabled(category.id == Category.allId)
                    .padding(.trailing, 10)
            }
            Button {
                addingCategory = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
            }
        }
        .alert("Add Category", isPresented: $addingCategory) {
            TextField("Enter category name", text: $newCategoryName)
                .keyboardType(.URL)
                .textContentType(.URL)
                .autocapitalization(.none)
            Button("Add Category") {
                let new = Category()
                new.id = UUID().uuidString
                new.textLabel = newCategoryName
                new.color = InciteColor.random
                new.incites = [incite]
                modelContext.insert(new)
                newCategoryName = ""
            }
            .disabled(newCategoryName.isEmpty)
            Button("Cancel", role: .cancel) {
                newCategoryName = ""
            }
        } message: {
            Text("Categories are used to group your incites.")
        }
    }
}

struct CategoryButton: View {
    @Binding var selected: Bool
    var label: String
    var inciteColor: InciteColor
    
    var body: some View {
        Button(label) {
            selected.toggle()
        }
        .font(.callout)
        .foregroundColor(.primary)
        .colorInvert()
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(selected ? inciteColor.color : .gray)
        .clipShape(Capsule())
    }
}



