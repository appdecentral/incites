//
//  EditInciteView.swift
//  Incites
//
//  Created by Drew McCormack on 04/10/2023.
//

import SwiftUI

struct EditInciteView: View {
    var incite: Incite
    var body: some View {
        Text("Item at \(incite.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
            .navigationTitle("Edit Incite")
    }
}

//#Preview {
//    EditInciteView()
//}
