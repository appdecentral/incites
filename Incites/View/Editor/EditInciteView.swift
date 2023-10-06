//
//  EditInciteView.swift
//  Incites
//
//  Created by Drew McCormack on 04/10/2023.
//

import SwiftUI
import SwiftData

struct EditInciteView: View {
    @Environment(\.modelContext) private var modelContext

    var inciteId: Incite.ID?
    @State var incite: Incite?
    
    var body: some View {
        Group {
            if let inciteBinding = Binding($incite) {
                ScrollView {
                    VStack {
                        InciteTextView(incite: inciteBinding)
                        CategoryGridView(incite: inciteBinding)
                        TriggerImageView(incite: inciteBinding)
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
