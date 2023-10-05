//
//  EditInciteView.swift
//  Incites
//
//  Created by Drew McCormack on 04/10/2023.
//

import SwiftUI
import SwiftData
import WrappingHStack

struct EditInciteView: View {
    @Environment(\.modelContext) private var modelContext
    var inciteId: Incite.ID?
    @State var incite: Incite?
    @State var addingCategory: Bool = false
    @State var newCategoryName: String = ""
    
    @Query(sort: [SortDescriptor(\Category.sortPriority, order: .reverse), SortDescriptor(\Category.textLabel)])
    var categories: [Category]
    
    var body: some View {
        Group {
            if nil != incite {
                ScrollView {
                    VStack {
                        Text("What is your incite?")
                            .font(.largeTitle.weight(.light))
                            .padding([.top, .bottom], 20)
                        TextEditor(text: Binding($incite)!.fact.text)
                            .frame(minHeight: 100)
                            .border(.secondary)
                        WrappingHStack {
                            ForEach(categories) { category in
                                let selectionBinding = Binding<Bool>(
                                    get: {
                                        incite!.categories.contains(category)
                                    },
                                    set: { newValue in
                                        if newValue {
                                            incite!.categories.append(category)
                                        } else {
                                            incite!.categories.removeAll(where: { $0 === category })
                                        }
                                    }
                                )
                                CategoryButton(selected: selectionBinding, label: category.textLabel, color: category.color)
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
                    }
                    .frame(maxWidth: 500)
                    .padding()
                }
            } else {
                Text("Make a Selection")
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            loadIncite()
        }
        .onChange(of: inciteId) {
            loadIncite()
        }
        .alert("Add Category", isPresented: $addingCategory) {
            TextField("Enter category name", text: $newCategoryName)
                .keyboardType(.URL)
                .textContentType(.URL)
                .autocapitalization(.none)
            Button("Add Category") {
                let new = Category(id: nil)
                new.textLabel = newCategoryName
                new.color = InciteColor.random
                new.incites.append(incite!)
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
    
    private func loadIncite() {
        guard let inciteId else {
            self.incite = nil
            return
        }
        let descriptor = FetchDescriptor<Incite>(predicate: #Predicate { $0.id == inciteId })
        self.incite = try! modelContext.fetch(descriptor).first
    }
}

struct CategoryButton: View {
    @Binding var selected: Bool
    var label: String
    var color: InciteColor
    
    var body: some View {
        Button(label) {
            selected.toggle()
        }
        .font(.callout)
        .foregroundColor(.primary)
        .colorInvert()
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(selected ? color.swiftUIColor : .gray)
        .clipShape(Capsule())
    }
}
