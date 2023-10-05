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
            if let incite {
                Text("Item at \(incite.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
            } else {
                Text("Make a Selection")
            }
        }
        .navigationTitle("Edit Incite")
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

