//
//  InciteTextView.swift
//  Incites
//
//  Created by Drew McCormack on 06/10/2023.
//

import SwiftUI
import SwiftData

struct InciteTextView: View {
    @Binding var incite: Incite

    var body: some View {
        Text("What is your incite?")
            .font(.largeTitle.weight(.light))
            .padding([.top, .bottom], 20)
        TextEditor(text: $incite.fact.text)
            .frame(minHeight: 100)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary, lineWidth: 1)
            }
            .padding(.bottom, 6)
        
    }
}
